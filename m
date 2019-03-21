Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E197EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87F920835
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RqPFykUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfCUAjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:39:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33914 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCUAjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 20:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pWI8n6jMtr3MXfAkN+nu7qTqCQE16kiViO+MHnFMiIw=; b=RqPFykUcJBkZVetf9y2ANL8Sd
        zmqhNKYkx0wUX/HTHwdzY+DjmY1srUxffDSBqWGDiB8FDwKABCPamzrsaktZhkeCLLuLWj+2ys+08
        lxnrFwJoTUxy/rH6zSzb54szYHM7YWMGrcSWlZDLRgIxOvk7XrC9XJqw3iqeD3Rq/cAgsWlwynlDG
        C7m9mKSWxbzSTkeEvqJL1JVK0ASBC1ctyIaB+RlAmqqT9UjkoubMmo6uT5DO+DMFbkmqKyBn1ixsa
        zooIdBEI68IcTzTKEAuougMfqlCE3257q5aVTbevRvFHxwFAreyQmoGMZ7toA9yRgk1lDlsjBrtA0
        PO7XTzR/A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6ljt-0002CN-Bf; Thu, 21 Mar 2019 00:39:21 +0000
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: what happened to SECURITY_DAC?
Message-ID: <ba89a02a-5550-689f-6609-1e8c025f5b91@infradead.org>
Date:   Wed, 20 Mar 2019 17:39:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wow.  Commit 70b62c25665f636c9f6c700b26af7df296b0887e
from last Sept. 14, 2018, total commit description says:

    LoadPin: Initialize as ordered LSM
    
    This converts LoadPin from being a direct "minor" LSM into an ordered LSM.

Nowhere does it say anything like "this also deletes any notions of
DEFAULT_SECURITY and DAC."

Was this deletion a (sekrit) security issue that was not being highlighted on purpose?


and what do you recommend for simple DAC-like security?

thanks.  :(

-- 
~Randy
