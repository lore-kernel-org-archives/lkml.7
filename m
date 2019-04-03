Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9423C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C6C20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554281786;
	bh=6zVS517b6cpZbWt4JwRUOIKdicoZMA2pSFqenMsFkyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WDAZYSS/OjMWMa47ZPpgMDwg3Ubc7YDwLNwMlu2gfxcTZhxys6nR01iNg0IRiQJ9V
	 hYeCAa7OZ4Suotm0Lc/6pHJEQRivJhXuLn8fC/3fYBUIS7eLBqR1NxRBIzlhVaf2qD
	 TjlFY2Q4CH9HMQFIvu9P8ek+KqF5kIMvo1Tvi0fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfDCI4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfDCI4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:56:25 -0400
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5554D206B7;
        Wed,  3 Apr 2019 08:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554281785;
        bh=6zVS517b6cpZbWt4JwRUOIKdicoZMA2pSFqenMsFkyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U2sPhNrOxLAvXJuUTHl5Um98KTXMJHQZ5GjBeYNCjkp7LhqKN28nJv6WfMLXOz/Gj
         Z4HEf48NLi/kmQ4ha2iE3kowwtW70+FeoFyiMPZL3Bwaa/fbQKjZwGdUlruOD05vGk
         SO5BQiqjAN7KUTTbArJVALYlnpCRvg+AuBQ4MWno=
Date:   Wed, 3 Apr 2019 10:56:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.0 000/146] 5.0.6-stable review
Message-ID: <20190403085622.GB4601@kroah.com>
References: <20190401170048.449559024@linuxfoundation.org>
 <e28284ac-f72a-113f-dbf9-0eb48aabb26a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e28284ac-f72a-113f-dbf9-0eb48aabb26a@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 05:34:16PM -0600, shuah wrote:
> On 4/1/19 11:00 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.6 release.
> > There are 146 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Apr  3 16:59:21 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.6-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing all of these and letting me know.

greg k-h
