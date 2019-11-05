Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26ABC5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35B221882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572977504;
	bh=XKt0cQyj1n3guOKO6hnFL8mI3gx00Jf2zG4WVGy3sh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SX6/ts6N/Kf9Z1yflymmTCHIpp/7KXG365jQiQ0EzRuNPzCHYFAwQxHspUqqyIV9S
	 8hZLaBNXfWx1kZ9+uJcfagTUw8YU36GkfD+ZGdiVlyuQ7nQ8Jw7bcAmjg1a57UztMr
	 3+/isvDYUt97Kmx6h7G+mkxnYPIkpFmIoAfWm+DI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390677AbfKESLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 13:11:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:46920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390634AbfKESLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 13:11:42 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E74F21928;
        Tue,  5 Nov 2019 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572977502;
        bh=XKt0cQyj1n3guOKO6hnFL8mI3gx00Jf2zG4WVGy3sh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HSbmJsg02vIRX4zE9Raspy+CgIkXhHwZbrA3kjdVB1l/NyCGahK+Qn9MstW3Ef9A5
         sXaGDhGdC3QaSILjkbxlk7jYzZOdnHfGWPhHUcQlQMCL3Bji5viD+gXm4XclqsWRTc
         HRS7Qj/AKQqnVyTVyDdB/PVb20tw2oTwR9asdHck=
Date:   Tue, 5 Nov 2019 18:11:38 +0000
From:   Will Deacon <will@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Zerella <adam.zerella@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: linux-next: manual merge of the jc_docs tree with the arm-perf
 tree
Message-ID: <20191105181137.GB32767@willie-the-truck>
References: <20191105113726.2a6e3317@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105113726.2a6e3317@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 11:37:26AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the jc_docs tree got a conflict in:
> 
>   Documentation/admin-guide/perf/imx-ddr.rst
> 
> between commits:
> 
>   76d835fcd429 ("docs/perf: Add explanation for DDR_CAP_AXI_ID_FILTER_ENHANCED quirk")
>   ed0207a33add ("docs/perf: Add AXI ID filter capabilities information")
> 
> from the arm-perf tree and commit:
> 
>   0522e130b00a ("docs: perf: Add imx-ddr to documentation index")
> 
> from the jc_docs tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Looks fine to me, thanks. Jon -- are you ok living with this conflict?

Will
