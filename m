Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852BDC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3372067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=didiksetiawan.com header.i=ds@didiksetiawan.com header.b="Q/oWxwMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfJJVPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 17:15:01 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21426 "EHLO
        sender4-of-o54.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJVPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:15:00 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Oct 2019 17:15:00 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1570741166; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=MT3hjDO4tOkZdDe44jV/yQoGxm9ZqGJ1bdQIbmP2i/EJ2+PCQq5Y4DzyJn3QKNbqJ2g19RaIaZkeG2WUkqybwS7tbo+A87XQKk4y1gR6UOCX4MNeCUkXuU2c9hmx9CjsLvlR/kkWDOmi0mKIB7PFzXQd1HJRwXLuFMHzKUwiYww=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1570741166; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=dPNtWA0Iz960tXwOsZN/Ef5wEwgoiqzvPe2KZB4O4E8=; 
        b=XEoC2phaeU1FWrQyjWgxrBR7JFuqiSvy897xCArdpwAXbaKXYr3pst9XnJdpQtkjtRRWPzIOJOe5diG+byHJy7DshxGjLe7RYS4euld7VeRxqNc2g3ZC+fCUygMLswe9E56Hp8MqG1ge7ZKHpeqJ8D+XzmU/dL9vRkwQt6F8k8U=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=didiksetiawan.com;
        spf=pass  smtp.mailfrom=ds@didiksetiawan.com;
        dmarc=pass header.from=<ds@didiksetiawan.com> header.from=<ds@didiksetiawan.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1570741166;
        s=zoho; d=didiksetiawan.com; i=ds@didiksetiawan.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        l=858; bh=dPNtWA0Iz960tXwOsZN/Ef5wEwgoiqzvPe2KZB4O4E8=;
        b=Q/oWxwMr388i1ZpVvqL+0FOPHeVHHTvJrCmIT7o2u0fBlT/gWPG5vOFBh1cKqsCr
        7MkK6oIW0heUsqe/ACFQzsuN1BBwZsPmwR+Q8VLotwyfOLjCfSdvEa/gPAejZR0HBBI
        wj1MxcZHgpLIN1plUTZtoZLJyjz1KZvkR1O1I9c4=
Received: from thinkpad-e420s (120.188.6.98 [120.188.6.98]) by mx.zohomail.com
        with SMTPS id 1570741163961789.4700517861468; Thu, 10 Oct 2019 13:59:23 -0700 (PDT)
Date:   Fri, 11 Oct 2019 03:59:16 +0700
From:   Didik Setiawan <ds@didiksetiawan.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.3 000/148] 5.3.6-stable review
Message-ID: <20191010205916.GA18683@thinkpad-e420s>
References: <20191010083609.660878383@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 10:34:21AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.3.6 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 12 Oct 2019 08:29:51 AM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.3.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled, booted, and no regressions found on my x86_64 system.

Thanks,
Didik Setiawan 

