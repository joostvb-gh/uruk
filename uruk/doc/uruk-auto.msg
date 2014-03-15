Return-Path: <W.S.L.Dankers@uvt.nl>
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on beskar.mdcc.cx
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	SPF_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2
X-Original-To: joostvb-uruk@mdcc.cx
Delivered-To: joostvb-uruk@mdcc.cx
Received: from poisson.uvt.nl (poisson.uvt.nl [137.56.247.187])
	by beskar.mdcc.cx (Postfix) with ESMTPS id 7B54221E12
	for <joostvb-uruk@mdcc.cx>; Fri,  7 Mar 2014 17:00:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by poisson.uvt.nl (Postfix) with ESMTP id 98141309
	for <joostvb-uruk@mdcc.cx>; Fri,  7 Mar 2014 17:00:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at uvt.nl
Received: from poisson.uvt.nl ([127.0.0.1])
	by localhost (poisson.uvt.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VzQwx_Oi8C1K for <joostvb-uruk@mdcc.cx>;
	Fri,  7 Mar 2014 17:00:23 +0100 (CET)
Received: from lagrange.uvt.nl (lagrange.uvt.nl [137.56.247.171])
	by poisson.uvt.nl (Postfix) with ESMTP id 19600306
	for <joostvb-uruk@mdcc.cx>; Fri,  7 Mar 2014 17:00:23 +0100 (CET)
Received: from homsar.uvt.nl (homsar.uvt.nl [137.56.163.115])
	by lagrange.uvt.nl (Postfix) with ESMTP id 17BD54000F9
	for <joostvb-uruk@mdcc.cx>; Fri,  7 Mar 2014 17:00:23 +0100 (CET)
Received: by homsar.uvt.nl (Postfix, from userid 488937)
	id 0A89EC17; Fri,  7 Mar 2014 17:00:23 +0100 (CET)
From: Wessel Dankers <wsl@fruit.je>
To: joostvb-uruk@mdcc.cx
Cc: Wessel Dankers <wsl@fruit.je>
Subject: [PATCH] autodetect-ips: debian inet6 stanzas default to netmask=64
Date: Fri,  7 Mar 2014 17:00:20 +0100
Message-Id: <1394208020-164526-1-git-send-email-wsl@fruit.je>
X-Mailer: git-send-email 1.7.9.5
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.2
   int  cnt   prob  spamicity histogram
  0.00   29 0.010336 0.010041 #############################
  0.10    1 0.117271 0.014060 #
  0.20    0 0.000000 0.014060 
  0.30    0 0.000000 0.014060 
  0.40    0 0.000000 0.014060 
  0.50    0 0.000000 0.014060 
  0.60    0 0.000000 0.014060 
  0.70    0 0.000000 0.014060 
  0.80    0 0.000000 0.014060 
  0.90    0 0.000000 0.014060 
Content-Length: 536

---
 uruk/init/autodetect-ips |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/uruk/init/autodetect-ips b/uruk/init/autodetect-ips
index 3da533c..7d8866a 100755
--- a/uruk/init/autodetect-ips
+++ b/uruk/init/autodetect-ips
@@ -74,6 +74,9 @@ then
                 esac
                 address=
                 netmask=
+                case $type in inet6)
+                    netmask=64
+                esac
             ;; address)
                     address=$val
                     case $address in */*)
-- 
1.7.9.5

