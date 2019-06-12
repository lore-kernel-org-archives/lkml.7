Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C6CC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753CA21734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560354978;
	bh=k/hMtfgh0gnlFLV5ceDoWrjDlKxQhSfkQrUrVvqt2TE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ukAYJlLSyKLFt87wOMm9yucUD1tUwMVAMdo1G5thpvI8bj1MflSf8lNWNC3GzqnhM
	 v+rqjFcbPPhLOh4ZOq1f2Tup8+DPJPYjh4m1BmjdrvjfTgx+fRpu4JyncQkTNWND/E
	 JTJR7/q3hxxSF1w6/SBXcDdy4KvQT3X7ryPRiEZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbfFLP4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbfFLP4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:56:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F3AE21019;
        Wed, 12 Jun 2019 15:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560354976;
        bh=k/hMtfgh0gnlFLV5ceDoWrjDlKxQhSfkQrUrVvqt2TE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oqwB1fhmzyUz3ozHx+V7Mtmc8jmTVMyKvkKpn6aQbZ3lqXW5YgZOXD0N/dLqBCn7W
         PFWeK66Q0m1jR8YCL+zijZ/09a5ZMz3AgMIPdZhoIZKL9zo67WNJzlZEaIasVH1GMB
         s6MMZU77KOYbtWfF8/6BKttKtsoymQ0ZIadzeanI=
Date:   Wed, 12 Jun 2019 17:56:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Brown <david.brown@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove myself as qcom maintainer
Message-ID: <20190612155614.GA27064@kroah.com>
References: <20190612155411.GA28186@davidb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612155411.GA28186@davidb.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 09:54:11AM -0600, David Brown wrote:
> I no longer regularly work on this platform, and only have a few
> increasingly outdated boards.  Andy has primarily been doing the
> maintenance.
> 
> Signed-off-by: David Brown <david.brown@linaro.org>
> ---
> MAINTAINERS | 1 -
> 1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57f496cff999..27df8f46a283 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2050,7 +2050,6 @@ S:	Maintained
> 
> ARM/QUALCOMM SUPPORT
> M:	Andy Gross <agross@kernel.org>
> -M:	David Brown <david.brown@linaro.org>
> L:	linux-arm-msm@vger.kernel.org
> S:	Maintained
> F:	Documentation/devicetree/bindings/soc/qcom/

Your patch is corrupted by having the leading spaces eaten up :(

