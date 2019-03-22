Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2AEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B622054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257532;
	bh=AkUmdsYypfrl9pl0ckXpNqBp+sBQnbWNcPyjqqey/6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fL82i+LTlWVCZLf5bGwaWLHaj9zhInLQBvsgf7P2pRP3INKPPT7jTkGGpj6il1hob
	 aOYw/C+Mhsy7aZnR/9cWPuFIK3CnxqGFvrF8HRmTiAkW4FYvfovR9/vxX8sa+hw7C9
	 mppP52vDngvkZsD/90Vp0FhbOt6sD5rQaMj1C8TE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391202AbfCVMX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:23:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391182AbfCVMXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:23:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7DAD218A1;
        Fri, 22 Mar 2019 12:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257432;
        bh=AkUmdsYypfrl9pl0ckXpNqBp+sBQnbWNcPyjqqey/6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZEc9ShVw4wKCAUxPkZe1JuSvWcWufnx45ARhShTSvY8sC3nANMOqf+BTau8Ht4isj
         T0ZIGPc/+itUh53RwERn1pG4M1ZYMT48xW/HMlNJSkxci3uunDZpSyW5MqW7GWMZYK
         eCIdR/hBADE0Z4xX7ZE2jHi7Y5GrYHNZZ4HliKrE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 5.0 197/238] stable-kernel-rules.rst: add link to networking patch queue
Date:   Fri, 22 Mar 2019 12:16:56 +0100
Message-Id: <20190322111309.818783621@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit a41e8f25fa8f8f67360d88eb0eebbabe95a64bdf upstream.

The networking maintainer keeps a public list of the patches being
queued up for the next round of stable releases.  Be sure to check there
before asking for a patch to be applied so that you do not waste
people's time.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/process/stable-kernel-rules.rst |    3 +++
 1 file changed, 3 insertions(+)

--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -38,6 +38,9 @@ Procedure for submitting patches to the
  - If the patch covers files in net/ or drivers/net please follow netdev stable
    submission guidelines as described in
    :ref:`Documentation/networking/netdev-FAQ.rst <netdev-FAQ>`
+   after first checking the stable networking queue at
+   https://patchwork.ozlabs.org/bundle/davem/stable/?series=&submitter=&state=*&q=&archive=
+   to ensure the requested patch is not already queued up.
  - Security patches should not be handled (solely) by the -stable review
    process but should follow the procedures in
    :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`.


