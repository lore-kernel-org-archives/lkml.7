Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94C2C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 00:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7BB20866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 00:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fsgEQ4A3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fsgEQ4A3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfEAAHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 20:07:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40446 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfEAAHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 20:07:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A52E6608CC; Wed,  1 May 2019 00:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556669251;
        bh=dAu7JXFbPaijmiIBB0IbVbY+HYF5UPs/C/cMlmqKdxA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fsgEQ4A3ntIzvdw5QeNiusiRKjkUrDsXdPVYEDCjnpX/ArGnw4ezRKDO1zES0tr1J
         OiW8wSq7yrxVBaGcu2qs3HvFPuZiEno+2AiMC2WP6jPoNkFhkRuybKgIYR95R4VJaX
         bZbH7NU4aeYXG0J3YvwX5ostS23R+b3oXQIxQpps=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 553E060735;
        Wed,  1 May 2019 00:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556669251;
        bh=dAu7JXFbPaijmiIBB0IbVbY+HYF5UPs/C/cMlmqKdxA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fsgEQ4A3ntIzvdw5QeNiusiRKjkUrDsXdPVYEDCjnpX/ArGnw4ezRKDO1zES0tr1J
         OiW8wSq7yrxVBaGcu2qs3HvFPuZiEno+2AiMC2WP6jPoNkFhkRuybKgIYR95R4VJaX
         bZbH7NU4aeYXG0J3YvwX5ostS23R+b3oXQIxQpps=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 30 Apr 2019 17:07:31 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     julien.thierry@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: PSCI version 1.1 and SYSTEM_RESET2
In-Reply-To: <24970f7101952f347bd4046c9a980473@codeaurora.org>
References: <24970f7101952f347bd4046c9a980473@codeaurora.org>
Message-ID: <efee74624f986a358b8986ae3085fba2@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-30 14:44, Sodagudi Prasad wrote:
+Sudeep

> Hi Mark/Will,
> 
> I would like to understand whether ARM linux community have plans to
> support PSCI version 1.1 or not.
> PSCI_1_1 specification introduced support for SYSTEM_RESET2 command
> and this new command helps mobile devices to SYSTEM_WARM_RESET
> support. Rebooting devices with warm reboot helps to capture the
> snapshot of the ram contents for post-mortem analysis.

I think, there is a recent discussion from Sudeep for the SYSTEM_RESET2 
support.
https://patchwork.kernel.org/patch/10884345/


Hi Sudeep,

I was going through your discussion in the below list -
https://lore.kernel.org/lkml/d73d3580-4ec1-a281-4585-5c776fc08c79@xilinx.com/

There is no provision to set up reboot mode dynamically instead kernel 
command line parameter.
Looking for options to reboot device with warm reboot option when kernel 
crashed.

panic() --> emergency_restart() --> machine_emergency_restart() --> 
machine_restart(NULL);

It would nice if there is a config option to reboot the device either in 
warm or cold in the case of kernel panic.
Calling machine_restart with a NULL parameter for kernel crash is 
leading to devices cold reboot.

-Thanks, Prasad

> 
> -Thanks, Prasad

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
