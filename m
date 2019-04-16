Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D05C10F12
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9713620656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383589;
	bh=9SpBKYxbDnnwjfgQatV7DRxNupYyZTmVh6qLIQEkbj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UT0iYb0JgS7msShh/rcDu2ZBWaDsO3L7ef9B+v3e+aejA47cNK0+hFGb0bRYtQIQs
	 LpDak6G2tvfP6OIqI2HACMoQFeEB3L31cxk4emW0dLBFzHZ/gyYBNWtnEmxuw6EJ3X
	 2M01h64dFOTa9RnLHOEvhMWmJ85EQ4KOHPbAQ8iQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfDPC7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:59:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44314 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfDPC4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SzV2S6/tr7UVf/FR5zSWGATUlf/T6mevh0ryPixjKPM=; b=okKprzzYHAeLc4wwrrpJcIjCpp
        D4ATRBYe6czdTytiWQPPSpCokNtOEKK/2oIqIftuQr2FO09IXBpFcXYhLlmhirPY8j0Q9dQ6pyx7i
        1JIsbwGJwdBjAIXI97xshpg8NyD0el4O47G/idzyCu2y9KkcA+KpQ2Kk+VKRvHpF90Z7rIPFvCXNn
        days6RRObyJV+Wx+BBl4ARlvbzUG26TflVTpfBqY62cpCd33sdmBDs+Z0zYcSZwM2mN1fSdA5gBqC
        EEm2LHp4+xKGK0H4o6lGr8tdu08zOiDpF0qrq35UhHgbYt/XRp/HYRqu/ivfH+f2+a7hpq58GeAwT
        RiBQRgMw==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGu-0007ae-LD; Tue, 16 Apr 2019 02:56:32 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGn-0001nQ-GX; Mon, 15 Apr 2019 23:56:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 23/57] docs: netlabel: convert it to ReST
Date:   Mon, 15 Apr 2019 23:55:48 -0300
Message-Id: <104211eb0db14790ad328fff7ad7f712d8d647f9.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert netlabel documentation to ReST.

This was trivial: just add proper title markups.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/netlabel/cipso_ipv4.txt    | 19 +++++++++++++------
 Documentation/netlabel/introduction.txt  | 16 +++++++++++-----
 Documentation/netlabel/lsm_interface.txt | 16 +++++++++++-----
 3 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/Documentation/netlabel/cipso_ipv4.txt b/Documentation/netlabel/cipso_ipv4.txt
index a6075481fd60..cbd3f3231221 100644
--- a/Documentation/netlabel/cipso_ipv4.txt
+++ b/Documentation/netlabel/cipso_ipv4.txt
@@ -1,10 +1,13 @@
+===================================
 NetLabel CIPSO/IPv4 Protocol Engine
-==============================================================================
+===================================
+
 Paul Moore, paul.moore@hp.com
 
 May 17, 2006
 
- * Overview
+Overview
+========
 
 The NetLabel CIPSO/IPv4 protocol engine is based on the IETF Commercial
 IP Security Option (CIPSO) draft from July 16, 1992.  A copy of this
@@ -13,7 +16,8 @@ draft can be found in this directory
 it to an RFC standard it has become a de-facto standard for labeled
 networking and is used in many trusted operating systems.
 
- * Outbound Packet Processing
+Outbound Packet Processing
+==========================
 
 The CIPSO/IPv4 protocol engine applies the CIPSO IP option to packets by
 adding the CIPSO label to the socket.  This causes all packets leaving the
@@ -24,7 +28,8 @@ label by using the NetLabel security module API; if the NetLabel "domain" is
 configured to use CIPSO for packet labeling then a CIPSO IP option will be
 generated and attached to the socket.
 
- * Inbound Packet Processing
+Inbound Packet Processing
+=========================
 
 The CIPSO/IPv4 protocol engine validates every CIPSO IP option it finds at the
 IP layer without any special handling required by the LSM.  However, in order
@@ -33,7 +38,8 @@ NetLabel security module API to extract the security attributes of the packet.
 This is typically done at the socket layer using the 'socket_sock_rcv_skb()'
 LSM hook.
 
- * Label Translation
+Label Translation
+=================
 
 The CIPSO/IPv4 protocol engine contains a mechanism to translate CIPSO security
 attributes such as sensitivity level and category to values which are
@@ -42,7 +48,8 @@ Domain Of Interpretation (DOI) definition and are configured through the
 NetLabel user space communication layer.  Each DOI definition can have a
 different security attribute mapping table.
 
- * Label Translation Cache
+Label Translation Cache
+=======================
 
 The NetLabel system provides a framework for caching security attribute
 mappings from the network labels to the corresponding LSM identifiers.  The
diff --git a/Documentation/netlabel/introduction.txt b/Documentation/netlabel/introduction.txt
index 3caf77bcff0f..9333bbb0adc1 100644
--- a/Documentation/netlabel/introduction.txt
+++ b/Documentation/netlabel/introduction.txt
@@ -1,10 +1,13 @@
+=====================
 NetLabel Introduction
-==============================================================================
+=====================
+
 Paul Moore, paul.moore@hp.com
 
 August 2, 2006
 
- * Overview
+Overview
+========
 
 NetLabel is a mechanism which can be used by kernel security modules to attach
 security attributes to outgoing network packets generated from user space
@@ -12,7 +15,8 @@ applications and read security attributes from incoming network packets.  It
 is composed of three main components, the protocol engines, the communication
 layer, and the kernel security module API.
 
- * Protocol Engines
+Protocol Engines
+================
 
 The protocol engines are responsible for both applying and retrieving the
 network packet's security attributes.  If any translation between the network
@@ -24,7 +28,8 @@ the NetLabel kernel security module API described below.
 Detailed information about each NetLabel protocol engine can be found in this
 directory.
 
- * Communication Layer
+Communication Layer
+===================
 
 The communication layer exists to allow NetLabel configuration and monitoring
 from user space.  The NetLabel communication layer uses a message based
@@ -33,7 +38,8 @@ formatting of these NetLabel messages as well as the Generic NETLINK family
 names can be found in the 'net/netlabel/' directory as comments in the
 header files as well as in 'include/net/netlabel.h'.
 
- * Security Module API
+Security Module API
+===================
 
 The purpose of the NetLabel security module API is to provide a protocol
 independent interface to the underlying NetLabel protocol engines.  In addition
diff --git a/Documentation/netlabel/lsm_interface.txt b/Documentation/netlabel/lsm_interface.txt
index 638c74f7de7f..026fc267f798 100644
--- a/Documentation/netlabel/lsm_interface.txt
+++ b/Documentation/netlabel/lsm_interface.txt
@@ -1,10 +1,13 @@
+========================================
 NetLabel Linux Security Module Interface
-==============================================================================
+========================================
+
 Paul Moore, paul.moore@hp.com
 
 May 17, 2006
 
- * Overview
+Overview
+========
 
 NetLabel is a mechanism which can set and retrieve security attributes from
 network packets.  It is intended to be used by LSM developers who want to make
@@ -12,7 +15,8 @@ use of a common code base for several different packet labeling protocols.
 The NetLabel security module API is defined in 'include/net/netlabel.h' but a
 brief overview is given below.
 
- * NetLabel Security Attributes
+NetLabel Security Attributes
+============================
 
 Since NetLabel supports multiple different packet labeling protocols and LSMs
 it uses the concept of security attributes to refer to the packet's security
@@ -24,7 +28,8 @@ configuration.  It is up to the LSM developer to translate the NetLabel
 security attributes into whatever security identifiers are in use for their
 particular LSM.
 
- * NetLabel LSM Protocol Operations
+NetLabel LSM Protocol Operations
+================================
 
 These are the functions which allow the LSM developer to manipulate the labels
 on outgoing packets as well as read the labels on incoming packets.  Functions
@@ -32,7 +37,8 @@ exist to operate both on sockets as well as the sk_buffs directly.  These high
 level functions are translated into low level protocol operations based on how
 the administrator has configured the NetLabel subsystem.
 
- * NetLabel Label Mapping Cache Operations
+NetLabel Label Mapping Cache Operations
+=======================================
 
 Depending on the exact configuration, translation between the network packet
 label and the internal LSM security identifier can be time consuming.  The
-- 
2.20.1

