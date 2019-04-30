Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59115C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 21:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF2920854
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 21:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FNDcQkJn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FNDcQkJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfD3Vo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 17:44:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34086 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfD3Vo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 17:44:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E39BF6020A; Tue, 30 Apr 2019 21:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556660696;
        bh=GaxIt+7bRIgTOt3LO61YtPvKLFWZmEpisbNXRWdc0Io=;
        h=Date:From:To:Cc:Subject:From;
        b=FNDcQkJnJf/BQtyjS5BVN779hFfQ0aBq3JU5sl8xcSmgpkawL0WQ36JwIjj2s40Kw
         L7QoC0433kFTb+OxHkYiTMzUdvxZUSs/HtU6WMQXn0aE8KHNOnK/iNpn50XN9uUStv
         rJhilMNkUCLvthte7Bj6gQEUKL7Je/WkamamsFHk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7A3186020A;
        Tue, 30 Apr 2019 21:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556660696;
        bh=GaxIt+7bRIgTOt3LO61YtPvKLFWZmEpisbNXRWdc0Io=;
        h=Date:From:To:Cc:Subject:From;
        b=FNDcQkJnJf/BQtyjS5BVN779hFfQ0aBq3JU5sl8xcSmgpkawL0WQ36JwIjj2s40Kw
         L7QoC0433kFTb+OxHkYiTMzUdvxZUSs/HtU6WMQXn0aE8KHNOnK/iNpn50XN9uUStv
         rJhilMNkUCLvthte7Bj6gQEUKL7Je/WkamamsFHk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 30 Apr 2019 14:44:56 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     julien.thierry@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: PSCI version 1.1 and SYSTEM_RESET2
Message-ID: <24970f7101952f347bd4046c9a980473@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark/Will,

I would like to understand whether ARM linux community have plans to 
support PSCI version 1.1 or not.
PSCI_1_1 specification introduced support for SYSTEM_RESET2 command and 
this new command helps mobile devices to SYSTEM_WARM_RESET support. 
Rebooting devices with warm reboot helps to capture the snapshot of the 
ram contents for post-mortem analysis.

-Thanks, Prasad
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
