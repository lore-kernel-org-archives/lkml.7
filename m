Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF836C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A46213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfFRNsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:48:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50120 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbfFRNsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:48:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hdET1-0001np-WD; Tue, 18 Jun 2019 13:48:08 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/spelling.txt: add more spellings to spelling.txt
Date:   Tue, 18 Jun 2019 14:48:07 +0100
Message-Id: <20190618134807.9729-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Here are even of the more common spelling mistakes and typos that I've
found while fixing up spelling mistakes in the kernel over the past few
months. Developers keep on coming up with more inventive ways to spell
words.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 scripts/spelling.txt | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 99f82a2a5b54..de75b9feaaed 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -41,6 +41,7 @@ accquired||acquired
 accross||across
 acessable||accessible
 acess||access
+acessing||accessing
 achitecture||architecture
 acient||ancient
 acitions||actions
@@ -54,6 +55,7 @@ activete||activate
 actived||activated
 actualy||actually
 acumulating||accumulating
+acumulative||accumulative
 acumulator||accumulator
 adapater||adapter
 addional||additional
@@ -103,6 +105,7 @@ alogrithm||algorithm
 alot||a lot
 alow||allow
 alows||allows
+alredy||already
 altough||although
 alue||value
 ambigious||ambiguous
@@ -223,6 +226,7 @@ boardcast||broadcast
 borad||board
 boundry||boundary
 brievely||briefly
+brigde||bridge
 broadcase||broadcast
 broadcat||broadcast
 bufufer||buffer
@@ -239,6 +243,7 @@ calulate||calculate
 cancelation||cancellation
 cancle||cancel
 capabilites||capabilities
+capabilties||capabilities
 capabilty||capability
 capabitilies||capabilities
 capablity||capability
@@ -325,6 +330,7 @@ conector||connector
 connecetd||connected
 configuartion||configuration
 configuation||configuration
+configued||configured
 configuratoin||configuration
 configuraton||configuration
 configuretion||configuration
@@ -407,6 +413,7 @@ depreacte||deprecate
 desactivate||deactivate
 desciptor||descriptor
 desciptors||descriptors
+descripto||descriptor
 descripton||description
 descrition||description
 descritptor||descriptor
@@ -432,6 +439,7 @@ deveolpment||development
 devided||divided
 deviece||device
 diable||disable
+dicline||decline
 dictionnary||dictionary
 didnt||didn't
 diferent||different
@@ -461,6 +469,7 @@ disharge||discharge
 disnabled||disabled
 dispertion||dispersion
 dissapears||disappears
+dissconect||disconnect
 distiction||distinction
 divisable||divisible
 divsiors||divisors
@@ -469,11 +478,14 @@ documantation||documentation
 documentaion||documentation
 documment||document
 doesnt||doesn't
+donwload||download
+donwloading||downloading
 dorp||drop
 dosen||doesn
 downlad||download
 downlads||downloads
 droped||dropped
+droput||dropout
 druing||during
 dynmaic||dynamic
 eanable||enable
@@ -482,6 +494,7 @@ ecspecially||especially
 edditable||editable
 editting||editing
 efective||effective
+effectivness||effectiveness
 efficently||efficiently
 ehther||ether
 eigth||eight
@@ -543,6 +556,7 @@ extensability||extensibility
 extention||extension
 extenstion||extension
 extracter||extractor
+faied||failed
 faield||failed
 falied||failed
 faild||failed
@@ -567,6 +581,7 @@ fetaures||features
 fileystem||filesystem
 fimware||firmware
 firmare||firmware
+firmaware||firmware
 firware||firmware
 finanize||finalize
 findn||find
@@ -601,6 +616,8 @@ funtions||functions
 furthur||further
 futhermore||furthermore
 futrue||future
+gatable||gateable
+gateing||gating
 gauage||gauge
 gaurenteed||guaranteed
 generiously||generously
@@ -641,9 +658,11 @@ iomaped||iomapped
 imblance||imbalance
 immeadiately||immediately
 immedaite||immediate
+immedate||immediate
 immediatelly||immediately
 immediatly||immediately
 immidiate||immediate
+immutible||immutable
 impelentation||implementation
 impementated||implemented
 implemantation||implementation
@@ -661,10 +680,12 @@ incative||inactive
 incomming||incoming
 incompatabilities||incompatibilities
 incompatable||incompatible
+incompatble||incompatible
 inconsistant||inconsistent
 increas||increase
 incremeted||incremented
 incrment||increment
+inculde||include
 indendation||indentation
 indended||intended
 independant||independent
@@ -778,6 +799,7 @@ libary||library
 librairies||libraries
 libraris||libraries
 licenceing||licencing
+logaritmic||logarithmic
 loggging||logging
 loggin||login
 logile||logfile
@@ -832,6 +854,7 @@ mispelled||misspelled
 mispelt||misspelt
 mising||missing
 mismactch||mismatch
+missign||missing
 missmanaged||mismanaged
 missmatch||mismatch
 miximum||maximum
@@ -848,6 +871,7 @@ mopdule||module
 mroe||more
 mulitplied||multiplied
 multidimensionnal||multidimensional
+multipe||multiple
 multple||multiple
 mumber||number
 muticast||multicast
@@ -870,7 +894,9 @@ nescessary||necessary
 nessessary||necessary
 noticable||noticeable
 notications||notifications
+notifcations||notifications
 notifed||notified
+notity||notify
 numebr||number
 numner||number
 obtaion||obtain
@@ -887,6 +913,7 @@ occuring||occurring
 offser||offset
 offet||offset
 offloded||offloaded
+offseting||offsetting
 omited||omitted
 omiting||omitting
 omitt||omit
@@ -1025,6 +1052,7 @@ prosess||process
 protable||portable
 protcol||protocol
 protecion||protection
+protedcted||protected
 protocoll||protocol
 promixity||proximity
 psudo||pseudo
@@ -1039,6 +1067,7 @@ reasearcher||researcher
 reasearchers||researchers
 reasearch||research
 recepient||recipient
+recevied||received
 receving||receiving
 recieved||received
 recieve||receive
@@ -1112,6 +1141,7 @@ retreived||retrieved
 retreive||retrieve
 retreiving||retrieving
 retrive||retrieve
+retrived||retrieved
 retuned||returned
 reudce||reduce
 reuest||request
@@ -1178,6 +1208,7 @@ singaled||signaled
 singal||signal
 singed||signed
 sleeped||slept
+sliped||slipped
 softwares||software
 speach||speech
 specfic||specific
@@ -1284,6 +1315,7 @@ threds||threads
 threshhold||threshold
 thresold||threshold
 throught||through
+trackling||tracking
 troughput||throughput
 thses||these
 tiggers||triggers
@@ -1410,5 +1442,6 @@ wnat||want
 workarould||workaround
 writeing||writing
 writting||writing
+wtih||with
 zombe||zombie
 zomebie||zombie
-- 
2.20.1

