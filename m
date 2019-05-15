Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAE0C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D5920657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557921754;
	bh=KW7rikDSm9f6i7sp99gWNsPanjsMokYBMeYmJ+3CyqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cx4V+ssSD+4tcz3KvZvDFNiqJdIb1iPUrr8A4Ysx5rYe/rpA27cyXIGEfiolJc/ao
	 iY59prWE774a29L/RWKIEXsLP6AK+nwmHygfFvPhgDi/NIbto3+RmCIEit5OeAGbv2
	 gtwQky0ixHBt1B+f9rdOrTMg7btB9YGPs6ItAEl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbfEOMCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729932AbfEOLNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:13:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 597B82084F;
        Wed, 15 May 2019 11:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918790;
        bh=KW7rikDSm9f6i7sp99gWNsPanjsMokYBMeYmJ+3CyqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LgQyfsvItwD+tmbhEMfTKmkai20Q0yo2Ls1DVe59u5sxvBNGss07ED7+7xT3G853R
         2IMsEtKhLEAC02EKWm+/0Yp9gYbqk8Wjf0lDrSzep9TLe3IaDFHBLtuhrv5H7qMAN5
         KFgbMqUoI0b4QDW27arM1xMFlrfOiazbM7tYDgNs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Bastian <jbastian@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 252/266] x86/speculation/mds: Fix documentation typo
Date:   Wed, 15 May 2019 12:55:59 +0200
Message-Id: <20190515090731.539432274@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 95310e348a321b45fb746c176961d4da72344282 upstream.

Fix a minor typo in the MDS documentation: "eanbled" -> "enabled".

Reported-by: Jeff Bastian <jbastian@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/x86/mds.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/x86/mds.rst
+++ b/Documentation/x86/mds.rst
@@ -116,7 +116,7 @@ Kernel internal mitigation modes
  off      Mitigation is disabled. Either the CPU is not affected or
           mds=off is supplied on the kernel command line
 
- full     Mitigation is eanbled. CPU is affected and MD_CLEAR is
+ full     Mitigation is enabled. CPU is affected and MD_CLEAR is
           advertised in CPUID.
 
  vmwerv	  Mitigation is enabled. CPU is affected and MD_CLEAR is not


