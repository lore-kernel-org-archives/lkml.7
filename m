Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DD1C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D8B20873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560891951;
	bh=OWTaSUxuYgnJOPKB46IIxNf0Q4Q627L7fu3/eClLaHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1GwvylW6M9gWdO9Z2iNLnC6CGX+m8rTHRM1OE4LUoKXPx+ZoQbGLXsiBaQeWqXzE4
	 eENDch9vv2C02VhLomUP9dQ0PbXO3hhAG87UP2EYYzzMAq6CzXAAiomeakB8DWIaxT
	 bENr33LFdGt0KhDMIun9rvECtSccojZlwm2uuObU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbfFRVFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 17:05:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34284 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730555AbfFRVFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 17:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6P57YxsmAx04truEVWlO1Rbm6PSISlvjP7Y4/ecme5A=; b=SPeh8yfMn1LqeFjeff3XUKVkdE
        7p76Cf1NT3yYrobDDeDK3K+E/Eka+Mh5SRM3ja9YlrEfGGGD5rw9iXmRMEBfJ+wUxCw2TEGK2+Tjc
        ArHXAHIgLCKfsjKEcWBOr7C0jyx2e05Fzq43bzPgoaQHFMtOxTZI+9eBMfXeBBnNcs7pSM9vG4j7h
        1AIcV8rY7LXRTN3mvZT2lTINYqh69yuBPiKA8dqprTTN9bhJyC9DY5ymFT68sEk4/dkQ3QsIfiwpt
        dVHmLsUXmN9gjXFEcVGPuqF5f5q5lfWM2fcr/3OfXrGAfR5IjhPyQQpf+Wp25wbzb7PLUYTXnXvGT
        dT98K3ww==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdLIb-0006ya-Ue; Tue, 18 Jun 2019 21:05:49 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdLIZ-0002CN-TK; Tue, 18 Jun 2019 18:05:47 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 10/22] docs: security: move some books to it and update
Date:   Tue, 18 Jun 2019 18:05:34 -0300
Message-Id: <79ece6b35e72852660e23631946dd6a145a1b744.1560891322.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560891322.git.mchehab+samsung@kernel.org>
References: <cover.1560891322.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following files belong to security:

  Documentation/security/LSM.rst -> Documentation/security/lsm-development.rst
  Documentation/lsm.txt -> Documentation/security/lsm.rst
  Documentation/SAK.txt -> Documentation/security/sak.rst
  Documentation/siphash.txt -> Documentation/security/siphash.rst

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/security/index.rst                        | 5 ++++-
 Documentation/security/{LSM.rst => lsm-development.rst} | 0
 Documentation/{ => security}/lsm.rst                    | 2 --
 Documentation/{SAK.rst => security/sak.rst}             | 2 --
 Documentation/{ => security}/siphash.rst                | 2 --
 Documentation/security/tpm/index.rst                    | 1 +
 Documentation/security/tpm/xen-tpmfront.rst             | 2 --
 7 files changed, 5 insertions(+), 9 deletions(-)
 rename Documentation/security/{LSM.rst => lsm-development.rst} (100%)
 rename Documentation/{ => security}/lsm.rst (99%)
 rename Documentation/{SAK.rst => security/sak.rst} (99%)
 rename Documentation/{ => security}/siphash.rst (99%)

diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index aad6d92ffe31..fc503dd689a7 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -8,7 +8,10 @@ Security Documentation
    credentials
    IMA-templates
    keys/index
-   LSM
+   lsm
+   lsm-development
+   sak
    SCTP
    self-protection
+   siphash
    tpm/index
diff --git a/Documentation/security/LSM.rst b/Documentation/security/lsm-development.rst
similarity index 100%
rename from Documentation/security/LSM.rst
rename to Documentation/security/lsm-development.rst
diff --git a/Documentation/lsm.rst b/Documentation/security/lsm.rst
similarity index 99%
rename from Documentation/lsm.rst
rename to Documentation/security/lsm.rst
index 4f0b1a6ea76c..ad4dfd020e0d 100644
--- a/Documentation/lsm.rst
+++ b/Documentation/security/lsm.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ========================================================
 Linux Security Modules: General Security Hooks for Linux
 ========================================================
diff --git a/Documentation/SAK.rst b/Documentation/security/sak.rst
similarity index 99%
rename from Documentation/SAK.rst
rename to Documentation/security/sak.rst
index 73dd10fa4337..64e667da93e0 100644
--- a/Documentation/SAK.rst
+++ b/Documentation/security/sak.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 =========================================
 Linux Secure Attention Key (SAK) handling
 =========================================
diff --git a/Documentation/siphash.rst b/Documentation/security/siphash.rst
similarity index 99%
rename from Documentation/siphash.rst
rename to Documentation/security/siphash.rst
index 833eef3a7956..9965821ab333 100644
--- a/Documentation/siphash.rst
+++ b/Documentation/security/siphash.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ===========================
 SipHash - a short input PRF
 ===========================
diff --git a/Documentation/security/tpm/index.rst b/Documentation/security/tpm/index.rst
index af77a7bbb070..3296533e54cf 100644
--- a/Documentation/security/tpm/index.rst
+++ b/Documentation/security/tpm/index.rst
@@ -5,3 +5,4 @@ Trusted Platform Module documentation
 .. toctree::
 
    tpm_vtpm_proxy
+   xen-tpmfront
diff --git a/Documentation/security/tpm/xen-tpmfront.rst b/Documentation/security/tpm/xen-tpmfront.rst
index 98a16ab87360..00d5b1db227d 100644
--- a/Documentation/security/tpm/xen-tpmfront.rst
+++ b/Documentation/security/tpm/xen-tpmfront.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ﻿=============================
 Virtual TPM interface for Xen
 =============================
-- 
2.21.0

