Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4ABC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 07:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B27622478
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 07:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570175738;
	bh=FNDLG3t0IQlsPlr+bG84V6ths9Nq5sKDMaq1tLgIGAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C8QUdb9sC27C9t39GGgTmi+PGfrOx+1gCkC5Yc4yiyJ+Q/Bfowzpgf6OlJp/fLx/n
	 +JRLN9MnO3YN+n4fHON7ddPeeRAH7pA0Zr/ddXR3rIQnG+0aRf0Wn9LjNaNIrcid7h
	 mvSznj/EUdwS9BvceVXHE+FCvGfYEJXfqetuFQQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388451AbfJDHzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 03:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387511AbfJDHzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 03:55:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F066207FF;
        Fri,  4 Oct 2019 07:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570175736;
        bh=FNDLG3t0IQlsPlr+bG84V6ths9Nq5sKDMaq1tLgIGAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J4ilZEJ3P8rk//4KiQG7UA3ewouA/RNLQOosLDvKnxunWIoN9j4n/sf9WPf40hzds
         A8rAblLvAXm7ukqK7KOPO+a15Ylvrm3SojkYv/XHlxvqhuQeqGVYP9FaA34BSZ+YhR
         DNDfReJk+55m2mtIr0dasvE7EDZti4m2/hAUEzRE=
Date:   Fri, 4 Oct 2019 09:55:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.2 000/313] 5.2.19-stable review
Message-ID: <20191004075534.GC10406@kroah.com>
References: <20191003154533.590915454@linuxfoundation.org>
 <5d967daa.1c69fb81.174c7.399f@mx.google.com>
 <7htv8pgzg9.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7htv8pgzg9.fsf@baylibre.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 04:51:34PM -0700, Kevin Hilman wrote:
> "kernelci.org bot" <bot@kernelci.org> writes:
> 
> > stable-rc/linux-5.2.y boot: 136 boots: 1 failed, 126 passed with 9 offline (v5.2.18-314-g2c8369f13ff8)
> >
> > Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-5.2.y/kernel/v5.2.18-314-g2c8369f13ff8/
> > Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.2.y/kernel/v5.2.18-314-g2c8369f13ff8/
> >
> > Tree: stable-rc
> > Branch: linux-5.2.y
> > Git Describe: v5.2.18-314-g2c8369f13ff8
> > Git Commit: 2c8369f13ff8c1375690964c79ffdc0e41ab4f97
> > Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > Tested: 80 unique boards, 27 SoC families, 16 builds out of 209
> 
> TL;DR; all is well.
> 
> > Boot Failure Detected:
> >
> > arm64:
> >     defconfig:
> >         gcc-8:
> >             rk3399-firefly: 1 failed lab
> 
> There's a known issue on this board I've been trying to debug with the
> mediatek maintainers, and we're not sure yet if it's a kernel issue or
> a hardware issue on my board, but for now, nothing to worry about for
> stable.

Thanks for the explaination and summary!

greg k-h
