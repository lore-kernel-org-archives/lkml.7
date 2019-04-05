Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48504C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B022171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RxkZ0/Zy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mMiy+n1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfDED2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:28:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47168 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbfDED2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:28:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 69781609F3; Fri,  5 Apr 2019 03:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554434911;
        bh=t7xcwQe1l/B+e308P3tsV50M+4VLIpAhLzkQn1cYbMc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RxkZ0/ZyNuDrjoXY+NGX5/o8DdrBsqwABbbjtRYlhHMMsiGZ4yPeNr80hTMS6iRe4
         p7uxrwvyI3KKzt656b5WKVxbD1Iax/cHZVjWyAxsBaphaZ5QVKv2379Xcju5+pPVFn
         GpmBXwhmvi6rFoPKzER4J2xUeZetPuwn/f2jeMN8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3521560770;
        Fri,  5 Apr 2019 03:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554434910;
        bh=t7xcwQe1l/B+e308P3tsV50M+4VLIpAhLzkQn1cYbMc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mMiy+n1tZ4rkvvniqdSR9v4ngIrEnAohQgkHKotOOJe/qiqEsSGZ24t+Aaua7AM1F
         uDKjWz2YoPrXlnH/dFF24Mp86ZItMxfkcMVY59NoSt37k51OlH3/p10KXr9r6bayPT
         q7lnJ3ctAYPrBGmwPWmGHarL8KoUPLdEOk7Sg3Jo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 05 Apr 2019 08:58:30 +0530
From:   saiprakash.ranjan@codeaurora.org
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH v2] drivers: firmware: psci: add support for warm reset
In-Reply-To: <20190403185123.15873-1-aaro.koskinen@iki.fi>
References: <20190403185123.15873-1-aaro.koskinen@iki.fi>
Message-ID: <39242b1d62b639f8fdc92029d737b5e0@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-04 00:21, Aaro Koskinen wrote:
> From: Aaro Koskinen <aaro.koskinen@nokia.com>
> 
> Add support for warm reset using SYSTEM_RESET2 introduced in PSCI
> 1.1 specification.
> 

There is already a patch sent by Sudeep for this support.

- 
https://lore.kernel.org/lkml/1525257003-8608-1-git-send-email-sudeep.holla@arm.com/

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
