Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12335C73C7F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D271320838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562745019;
	bh=exaz+qLfEjNdZCRHTVw4B1zq/sgPHEuhCmHhmJF4SIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qZujYFo/9m04Mwniy79l25hmA2K3N8hhNA1cYvo5wKLjMRTtWifMq17gX+xcggap9
	 b9y08+8NJIGBkXHBAJhhJUKtR6k8ima7ruyT0Z4ZsPaQHm+nny03bgzzQyWJqijOqo
	 CGVW62qgHnHy+LJda1+cN69Z4YNRpoNRRigCEQuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfGJHuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 03:50:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfGJHuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:50:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B1FA20651;
        Wed, 10 Jul 2019 07:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562745017;
        bh=exaz+qLfEjNdZCRHTVw4B1zq/sgPHEuhCmHhmJF4SIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=17XxH+RjqlAcNBBMbQLWJJUTeotMr7ox9zSc5XV3SFN2AYFYdNmNzsVy8MDwY+HnW
         mxS9VuFugZNWGqmg+F7vHfNwuXkIsVzWSzJWFVdS1Z2R4ZIFIDCedtYaPtQSdHgg0d
         3ZHcWC20He/gKsnIJQ6cUB0UcSHIDlp1TOdhemIQ=
Date:   Wed, 10 Jul 2019 09:50:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 5.1 00/96] 5.1.17-stable review
Message-ID: <20190710075014.GC5186@kroah.com>
References: <20190708150526.234572443@linuxfoundation.org>
 <c1498293-f0f6-0599-bd72-4156370a7599@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1498293-f0f6-0599-bd72-4156370a7599@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 12:49:48AM +0700, Phong Tran wrote:
> On 7/8/19 10:12 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.1.17 release.
> > There are 96 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed 10 Jul 2019 03:03:52 PM UTC.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1.17-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.1.y
> > and the diffstat can be found below.
> > 
> 
> build and boot fine with qemu-system-riscv64
> 
> root@(none):~# uname  -a
> Linux (none) 5.1.17-rc1-00097-gb64119f8dffe #4 SMP Tue Jul 9 00:44:23 +07
> 2019 riscv64 GNU/Linux
> root@(none):~# cat /proc/cpuinfo
> processor	: 0
> hart		: 0
> isa		: rv64imafdcu
> mmu		: sv48
> 

riscv on quemu, interesting choice!

Note, Guenter's tests do check this type of thing already, but thanks
for doing this.

greg k-h
