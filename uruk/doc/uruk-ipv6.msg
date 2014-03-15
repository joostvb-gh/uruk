Return-Path: <W.S.L.Dankers@uvt.nl>
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on beskar.mdcc.cx
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	SPF_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2
X-Original-To: joostvb-uruk@mdcc.cx
Delivered-To: joostvb-uruk@mdcc.cx
Received: from poisson.uvt.nl (poisson.uvt.nl [137.56.247.187])
	by beskar.mdcc.cx (Postfix) with ESMTPS id 8813121EF4
	for <joostvb-uruk@mdcc.cx>; Fri,  7 Mar 2014 14:39:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by poisson.uvt.nl (Postfix) with ESMTP id 4BD6F304
	for <joostvb-uruk@mdcc.cx>; Fri,  7 Mar 2014 14:39:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at uvt.nl
Received: from poisson.uvt.nl ([127.0.0.1])
	by localhost (poisson.uvt.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 86Jajxyrhxp9 for <joostvb-uruk@mdcc.cx>;
	Fri,  7 Mar 2014 14:39:24 +0100 (CET)
Received: from lagrange.uvt.nl (lagrange.uvt.nl [137.56.247.171])
	by poisson.uvt.nl (Postfix) with ESMTP id BCFBB301
	for <joostvb-uruk@mdcc.cx>; Fri,  7 Mar 2014 14:39:24 +0100 (CET)
Received: from homsar.uvt.nl (homsar.uvt.nl [137.56.163.115])
	by lagrange.uvt.nl (Postfix) with ESMTP id B96274000F9
	for <joostvb-uruk@mdcc.cx>; Fri,  7 Mar 2014 14:39:24 +0100 (CET)
Received: by homsar.uvt.nl (Postfix, from userid 488937)
	id AEF3D20813; Fri,  7 Mar 2014 14:39:24 +0100 (CET)
From: Wessel Dankers <wsl@fruit.je>
To: joostvb-uruk@mdcc.cx
Cc: Wessel Dankers <wsl@fruit.je>
Subject: [PATCH] Use sources_${iface}_${proto}_${service} for IPv6.
Date: Fri,  7 Mar 2014 14:39:00 +0100
Message-Id: <1394199540-133252-1-git-send-email-wsl@fruit.je>
X-Mailer: git-send-email 1.7.9.5
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.2
   int  cnt   prob  spamicity histogram
  0.00   62 0.018577 0.016353 ################################################
  0.10    6 0.111987 0.025795 #####
  0.20    0 0.000000 0.025795 
  0.30    0 0.000000 0.025795 
  0.40    0 0.000000 0.025795 
  0.50    0 0.000000 0.025795 
  0.60    0 0.000000 0.025795 
  0.70    0 0.000000 0.025795 
  0.80    0 0.000000 0.025795 
  0.90    3 0.992992 0.175604 ###
Content-Length: 6093

Before this change, uruk required seperate sources_* and sources6_*
variables to configure access for v4/v6 sources. With this patch
the rules are as follows:

1) If both sources_* and sources6_* are defined (even if they're just
   empty), each is used for its respective address family.
   This ensures backwards compatibility.

2) If sources6_* is undefined, sources_* is used for both v4 and v6.

3) In either case, v4 literals in v6 context and v6 literals in v4
   context are silently ignored.

This patch also fixes the detection of undefined variables, which
was broken.
---
 uruk/script/uruk |   75 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/uruk/script/uruk b/uruk/script/uruk
index 9b2fef3..4a19d6d 100644
--- a/uruk/script/uruk
+++ b/uruk/script/uruk
@@ -247,72 +247,75 @@ uruk_hook "$rc_c"
 #
 for iface in $interfaces
 do
-    eval is="\"\$ips_${iface}\""
-    if test -n "$is"
-    then
+    eval "is=\$ips_${iface}"
+    case $is in '')
+        interfaces_x=$iface
+    ;; *)
         interfaces_x=
         for i in $is
         do
             interfaces_x="$interfaces_x ${iface}_$i"
         done
-    else
-        interfaces_x=$iface
-    fi
+    esac
 
     for iface_x in $interfaces_x
     do
-        eval ip="\"\$ip_${iface_x}\""
-        eval ip6="\"\$ip6_${iface_x}\""
+        eval "ip=\$ip_${iface_x}"
+        eval "ip6=\$ip6_${iface_x}"
         for proto in tcp udp
         do
-            eval services="\"\$services_${iface_x}_${proto}\""
-            if test -n "$services"
-            then
+            eval "services_defined=\${services_${iface_x}_${proto}+DEFINED}"
+            eval "services=\$services_${iface_x}_${proto}"
+            case $services_defined in '')
+                echo >&2 "WARNING: services_${iface_x}_${proto} is undefined.  (Processing uruk rc file nevertheless.)"
+            ;; *)
                 for service in $services
                 do
                     # service is a servicegroupname, e.g. "local"
-                    eval sources="\"\$sources_${iface_x}_${proto}_${service}\""
-                    case ${sources-UNDEF} in UNDEF)
-                        echo >&2 "WARNING: sources_${iface_x}_${proto}_${service} is undefined.
- (Processing uruk rc file nevertheless.)"
+                    eval "sources_defined=\${sources_${iface_x}_${proto}_${service}+DEFINED}"
+                    eval "sources=\$sources_${iface_x}_${proto}_${service}"
+                    case $sources_defined in '')
+                        echo >&2 "WARNING: sources_${iface_x}_${proto}_${service} is undefined.  (Processing uruk rc file nevertheless.)"
                     esac
 
-                    eval sources6="\"\$sources6_${iface_x}_${proto}_${service}\""
-                    case ${sources6-UNDEF} in UNDEF)
-                        echo >&2 "INFO: sources6_${iface_x}_${proto}_${service} is undefined.
- (Processing uruk rc file nevertheless.)"
+                    eval "sources6_defined=\${sources6_${iface_x}_${proto}_${service}+DEFINED}"
+                    eval "sources6=\$sources6_${iface_x}_${proto}_${service}"
+                    case $sources6_defined in '')
+                        eval "sources6=\$sources_${iface_x}_${proto}_${service}"
                     esac
 
-                    eval ports="\"\$ports_${iface_x}_${proto}_${service}\""
-                    if test -n "$ports"
-                    then
+                    eval "ports_defined=\${ports_${iface_x}_${proto}_${service}+DEFINED}"
+                    eval "ports=\$ports_${iface_x}_${proto}_${service}"
+                    case $ports_defined in '')
+                        echo >&2 "WARNING: ports_${iface_x}_${proto}_${service} is undefined.  (Processing uruk rc file nevertheless.)"
+                    ;; *)
                         for port in $ports
                         do
                             # port is e.g. www or 1023
-                            if test -n "$sources"
-                            then
-                                for source in $sources
-                                do
+                            for source in $sources
+                            do
+                                case $source in *:*) ;; *) # if it doesn't look like an IPv6 address/range
                                     # source is e.g. 10.56.0.10/32
                                     $iptables -A INPUT -m conntrack --ctstate NEW \
                                       -i $iface --protocol $proto \
                                       --source "$source" --destination "$ip" \
                                       --destination-port "$port" -j ACCEPT
-                                done
-                            fi
+                                esac
+                            done
+
                             for source6 in $sources6
                             do
-                                $ip6tables -A INPUT -m conntrack --ctstate NEW \
-                                  -i $iface --protocol $proto \
-                                  --source "$source6" --destination "$ip6" \
-                                  --destination-port "$port" -j ACCEPT
+                                case $source6 in *[!0-9/.]*) # if it doesn't look like an IPv4 address/range
+                                    $ip6tables -A INPUT -m conntrack --ctstate NEW \
+                                      -i $iface --protocol $proto \
+                                      --source "$source6" --destination "$ip6" \
+                                      --destination-port "$port" -j ACCEPT
+                                esac
                             done
                         done
-                    else
-                        echo >&2 "WARNING: ports_${iface_x}_${proto}_${service} is undefined.  (Processing uruk rc file nevertheless.)"
-                    fi
+                    esac
                 done
-            fi
+            esac
         done
     done
 done
-- 
1.7.9.5

