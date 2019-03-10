Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BB4C10F03
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 06:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB1E20870
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 06:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552197935;
	bh=K1wDgvJF55LI0n1C8asoVhBi6zyc+tlQ9vECYgprnt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jkFpk92eAP4VDb+xcIWRjpoHYjisUlq1lQ3ajOdf4qp60vkct5cOLFzalgWdRMrKi
	 PLj/z0CwDEaPlNtGSUETeMTl8ZX+gm24Utpp+4jT3PO+wDHSsseBl7QA8B8W6W2A9m
	 Bc9dBNgEBvQ5hShQQA1j8+hRjzwVG4N8a1VTSua0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbfCJGFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 01:05:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfCJGFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 01:05:33 -0500
Received: from localhost (unknown [89.248.140.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A78E120657;
        Sun, 10 Mar 2019 06:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552197933;
        bh=K1wDgvJF55LI0n1C8asoVhBi6zyc+tlQ9vECYgprnt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wEW2KDVHRpWVmMLr0Ct1GxJQb0fpvDR3jmBoof+PPEanxxGHmvvsyR7WYUVw1oz5r
         dG6EwkxAbt+Fo4Fl69E6y6NXE4ZoNjjc2AeRI1juzDHsAMietTY7/BY1PxT+hZjTVB
         dTJtpS3C5ttEnzKxbl+5ZwItaVYOCEiMJ/JgC9SU=
Date:   Sun, 10 Mar 2019 07:05:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 00/46] 5.0.1-stable review
Message-ID: <20190310060530.GA3255@kroah.com>
References: <20190308124902.257040783@linuxfoundation.org>
 <db623c17-a448-47c6-0132-3ee3d05d3c65@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db623c17-a448-47c6-0132-3ee3d05d3c65@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2019 at 02:36:17PM -0800, Guenter Roeck wrote:
> On 3/8/19 4:49 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.1 release.
> > There are 46 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Mar 10 12:48:36 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 343 pass: 343 fail: 0

Wonderful, thanks for testing all of these and letting me know.

greg k-h
