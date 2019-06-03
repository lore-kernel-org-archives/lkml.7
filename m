Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4255C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7866725C0B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559567973;
	bh=iTXPAmNoS8U3ZfZP8OM65q8vMO1UxvNGuf2LD/JekMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lzbdkpginpm5Z9OFBSZU36wh7oMTIVWV88TwOj3ya96xtyc566Q9HGMkyBRqrf/dF
	 B3yLL46KU9WaLRuEpGP2tQoIlUsNOBhHugo6BcwCRm/IsY2bZUUxXWcyzalVbjttL0
	 oq4zqRRXlEoEb1QWBVdPa1n6InCWVBekHehz8XQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfFCNTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfFCNTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:19:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59C5525162;
        Mon,  3 Jun 2019 13:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559567972;
        bh=iTXPAmNoS8U3ZfZP8OM65q8vMO1UxvNGuf2LD/JekMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CcGJJpFmrlsHX6mBdHs3v0fHB1uavQRKBc6nMPgrNFeen9ngnUkvK6oNt03IYRjM8
         I4SN83kxaM1SHFkzKdey4/tTLsAKzAKPvqLpp6eq9ab82M065aQOLOwFL+tt1pdKMq
         uG8Oa7CoQVojZ79ad9OjscM4AF2roixRmat1GcO0=
Date:   Mon, 3 Jun 2019 15:19:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yu Chen <chenyu56@huawei.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v6 05/10] usb: roles: Introduce stubs for the exiting
 functions in role.h.
Message-ID: <20190603131929.GC10397@kroah.com>
References: <1559115828-19146-1-git-send-email-chunfeng.yun@mediatek.com>
 <1559115828-19146-6-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559115828-19146-6-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 03:43:43PM +0800, Chunfeng Yun wrote:
> From: Yu Chen <chenyu56@huawei.com>
> 
> This patch adds stubs for the exiting functions while
> CONFIG_USB_ROLE_SWITCH does not enabled.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>

Same here, you need to sign off on it too.

thanks,

greg k-h
