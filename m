Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A38ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0F62089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=didiksetiawan.com header.i=ds@didiksetiawan.com header.b="KfyqrKg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439045AbfJQSg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 14:36:28 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21442 "EHLO
        sender4-of-o54.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404424AbfJQSg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:36:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571337357; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=GZ0wkqT4oX70b4/Yw7CTeHHoyNrnOItU1Avnktv0zPsd75nDD7Ux05VFtEdRJ7OH4w/IImYQEARcSdF52WUWwtQyJYCigMfCLVUGDYoY0I1oMGKdlRhG6zbHSuKFwg/87qJWf2sdV2Ykic6zm0xwkjfOgl6XLPEdxed0bOwEBgY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1571337357; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=xpH+wwCAITSzAO9czGlDj9un1CpDMmdRQVqIEoGfq70=; 
        b=kIt5Q300JKxlLLQ0InuiBOme/SWy/3ozlG7qRKZrawRplc+5ERNvAMrYu3EEi/x4iwpxZxT1W4UVHYpCs8tJ1XLnCpQ3oWctK53F0VQljcaneIIkwfFFxNYdEwh0rpIAa4+J/ddZmiGU/YTQfdyB2A3/EmVrFD8PnmFq/5vklEA=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=didiksetiawan.com;
        spf=pass  smtp.mailfrom=ds@didiksetiawan.com;
        dmarc=pass header.from=<ds@didiksetiawan.com> header.from=<ds@didiksetiawan.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571337357;
        s=zoho; d=didiksetiawan.com; i=ds@didiksetiawan.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        l=859; bh=xpH+wwCAITSzAO9czGlDj9un1CpDMmdRQVqIEoGfq70=;
        b=KfyqrKg9pr8q+C9r1woJfkGlVle+OvcXS+1rn5cfraXq4OTUL7Qc5znjYjDcc+q/
        ARXXcisai8HQcwIsti+lwLzXheIq08kJ1VppW0pGCOfFypLm6DOQdceddtgTHavPkQT
        sQeOw7ffY1ChOQN6rPbodulUkxyiKDQm3fN4uEqw=
Received: from thinkpad-e420s (120.188.94.47 [120.188.94.47]) by mx.zohomail.com
        with SMTPS id 1571337356737811.3215165603303; Thu, 17 Oct 2019 11:35:56 -0700 (PDT)
Date:   Fri, 18 Oct 2019 01:35:44 +0700
From:   Didik Setiawan <ds@didiksetiawan.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/81] 4.19.80-stable review
Message-ID: <20191017183544.GA9782@thinkpad-e420s>
References: <20191016214805.727399379@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016214805.727399379@linuxfoundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 02:50:11PM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.80 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 18 Oct 2019 09:43:41 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.80-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Compiled, booted, and no regressions found on my x86_64 system.

Thanks,
Didik Setiawan

