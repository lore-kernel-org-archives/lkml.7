Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71311C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456352196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfKLJVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:21:45 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45718 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfKLJVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:21:45 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iUSMp-0007DW-5p; Tue, 12 Nov 2019 09:21:43 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/spelling.txt: add more spellings to spelling.txt
Date:   Tue, 12 Nov 2019 09:21:42 +0000
Message-Id: <20191112092142.97989-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Here are some of the more common spelling mistakes and typos that I've
found while fixing up spelling mistakes in the kernel since July 2019.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 scripts/spelling.txt | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index de75b9feaaed..672b5931bc8d 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -87,6 +87,7 @@ algorith||algorithm
 algorithmical||algorithmically
 algoritm||algorithm
 algoritms||algorithms
+algorithmn||algorithm
 algorrithm||algorithm
 algorritm||algorithm
 aligment||alignment
@@ -109,6 +110,7 @@ alredy||already
 altough||although
 alue||value
 ambigious||ambiguous
+ambigous||ambiguous
 amoung||among
 amout||amount
 amplifer||amplifier
@@ -179,6 +181,7 @@ attepmpt||attempt
 attnetion||attention
 attruibutes||attributes
 authentification||authentication
+authenicated||authenticated
 automaticaly||automatically
 automaticly||automatically
 automatize||automate
@@ -286,6 +289,7 @@ claread||cleared
 clared||cleared
 closeing||closing
 clustred||clustered
+cnfiguration||configuration
 coexistance||coexistence
 colescing||coalescing
 collapsable||collapsible
@@ -325,9 +329,11 @@ comression||compression
 comunication||communication
 conbination||combination
 conditionaly||conditionally
+conditon||condition
 conected||connected
 conector||connector
 connecetd||connected
+configration||configuration
 configuartion||configuration
 configuation||configuration
 configued||configured
@@ -347,6 +353,7 @@ containts||contains
 contaisn||contains
 contant||contact
 contence||contents
+contiguos||contiguous
 continious||continuous
 continous||continuous
 continously||continuously
@@ -380,6 +387,7 @@ cylic||cyclic
 dafault||default
 deafult||default
 deamon||daemon
+debouce||debounce
 decompres||decompress
 decsribed||described
 decription||description
@@ -448,6 +456,7 @@ diffrent||different
 differenciate||differentiate
 diffrentiate||differentiate
 difinition||definition
+digial||digital
 dimention||dimension
 dimesions||dimensions
 dispalying||displaying
@@ -489,6 +498,7 @@ droput||dropout
 druing||during
 dynmaic||dynamic
 eanable||enable
+eanble||enable
 easilly||easily
 ecspecially||especially
 edditable||editable
@@ -502,6 +512,7 @@ elementry||elementary
 eletronic||electronic
 embeded||embedded
 enabledi||enabled
+enbale||enable
 enble||enable
 enchanced||enhanced
 encorporating||incorporating
@@ -536,6 +547,7 @@ excellant||excellent
 execeeded||exceeded
 execeeds||exceeds
 exeed||exceed
+exeuction||execution
 existance||existence
 existant||existent
 exixt||exist
@@ -601,10 +613,12 @@ frambuffer||framebuffer
 framming||framing
 framwork||framework
 frequncy||frequency
+frequancy||frequency
 frome||from
 fucntion||function
 fuction||function
 fuctions||functions
+fullill||fulfill
 funcation||function
 funcion||function
 functionallity||functionality
@@ -642,6 +656,7 @@ happend||happened
 harware||hardware
 heirarchically||hierarchically
 helpfull||helpful
+hexdecimal||hexadecimal
 hybernate||hibernate
 hierachy||hierarchy
 hierarchie||hierarchy
@@ -709,12 +724,14 @@ initalize||initialize
 initation||initiation
 initators||initiators
 initialiazation||initialization
+initializationg||initialization
 initializiation||initialization
 initialze||initialize
 initialzed||initialized
 initialzing||initializing
 initilization||initialization
 initilize||initialize
+initliaze||initialize
 inofficial||unofficial
 inrerface||interface
 insititute||institute
@@ -779,6 +796,7 @@ itertation||iteration
 itslef||itself
 jave||java
 jeffies||jiffies
+jumpimng||jumping
 juse||just
 jus||just
 kown||known
@@ -839,6 +857,7 @@ messags||messages
 messgaes||messages
 messsage||message
 messsages||messages
+metdata||metadata
 micropone||microphone
 microprocesspr||microprocessor
 migrateable||migratable
@@ -857,6 +876,7 @@ mismactch||mismatch
 missign||missing
 missmanaged||mismanaged
 missmatch||mismatch
+misssing||missing
 miximum||maximum
 mmnemonic||mnemonic
 mnay||many
@@ -912,6 +932,7 @@ occured||occurred
 occuring||occurring
 offser||offset
 offet||offset
+offlaod||offload
 offloded||offloaded
 offseting||offsetting
 omited||omitted
@@ -993,6 +1014,7 @@ poiter||pointer
 posible||possible
 positon||position
 possibilites||possibilities
+potocol||protocol
 powerfull||powerful
 pramater||parameter
 preamle||preamble
@@ -1061,11 +1083,13 @@ psychadelic||psychedelic
 pwoer||power
 queing||queuing
 quering||querying
+queus||queues
 randomally||randomly
 raoming||roaming
 reasearcher||researcher
 reasearchers||researchers
 reasearch||research
+receieve||receive
 recepient||recipient
 recevied||received
 receving||receiving
@@ -1166,6 +1190,7 @@ scaleing||scaling
 scaned||scanned
 scaning||scanning
 scarch||search
+schdule||schedule
 seach||search
 searchs||searches
 secquence||sequence
@@ -1308,6 +1333,7 @@ taskelt||tasklet
 teh||the
 temorary||temporary
 temproarily||temporarily
+temperture||temperature
 thead||thread
 therfore||therefore
 thier||their
@@ -1354,6 +1380,7 @@ uknown||unknown
 usupported||unsupported
 uncommited||uncommitted
 unconditionaly||unconditionally
+undeflow||underflow
 underun||underrun
 unecessary||unnecessary
 unexecpted||unexpected
@@ -1414,6 +1441,7 @@ varible||variable
 varient||variant
 vaule||value
 verbse||verbose
+veify||verify
 verisons||versions
 verison||version
 verson||version
-- 
2.20.1

