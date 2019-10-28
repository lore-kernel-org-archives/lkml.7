Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09847CA9EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 04:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C545A2184C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 04:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=didiksetiawan.com header.i=ds@didiksetiawan.com header.b="Y87v6ugj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfJ1Ejq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 00:39:46 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21427 "EHLO
        sender4-of-o54.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfJ1Ejp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 00:39:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572237546; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=CpFBBWjERBJ3cKBVNHuwjpaeShDrpL4mDpk7NZ/tDyJWVtn9TNshu4m6ZQQkaoMPTMqzo0IVFfp9Xj53bazhhgXb7Xuv/5KR4R8G5YoY7xO/8Bn6362cFrEp4Z0nEgRzWFazFlxOE4yMdVyn16m9BCeT5dqkwFBCV1AtXNSdIXk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1572237546; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=bFB0pVj3q69YS47LEB4+p6yzNDeTqcKBksznuz1aAK4=; 
        b=aC+sm7wsAvU5S2SO3ES9e6/5p4+fYhdoaabzMKsy699BHTJgAwd+5ool0SlCw5S/xDX4+tzA3VW/X8BgyGu/nvsVG3hKCEY1rRqbOfjVVOl+KtUNedTHZhnbj3hFaSTfHmJuc07Be9rYKGB95r+t4/3nUBALEiZVY/3jIIPodUA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=didiksetiawan.com;
        spf=pass  smtp.mailfrom=ds@didiksetiawan.com;
        dmarc=pass header.from=<ds@didiksetiawan.com> header.from=<ds@didiksetiawan.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1572237546;
        s=zoho; d=didiksetiawan.com; i=ds@didiksetiawan.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        l=855; bh=bFB0pVj3q69YS47LEB4+p6yzNDeTqcKBksznuz1aAK4=;
        b=Y87v6ugjcp23bN6Kta9K+OChjIE4bN6hKDf8sJII6dQQj46CVI7YBCv2TqH5otg8
        uf/zo02zcZeq92Nik1JBl26BuBFGq9wqBwIIYML5fF9TwJn49i8B8TbkOZlDJUtHBXR
        mm6Cfee/1vwWg/+NhK7FgfT0L9Kc0s8cuiR8Ntss=
Received: from notebook (117.102.74.82 [117.102.74.82]) by mx.zohomail.com
        with SMTPS id 1572237544365671.9832677221943; Sun, 27 Oct 2019 21:39:04 -0700 (PDT)
Date:   Mon, 28 Oct 2019 11:38:55 +0700
From:   Didik Setiawan <ds@didiksetiawan.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.3 000/197] 5.3.8-stable review
Message-ID: <20191028043855.GA18500@notebook>
References: <20191027203351.684916567@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2019 at 09:58:38PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.3.8 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue 29 Oct 2019 08:27:02 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.3.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
 
Compiled, booted, and no regressions found on my x86_64 system.

Thanks,
Didik Setiawan

