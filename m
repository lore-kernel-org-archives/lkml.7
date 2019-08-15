Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DF4C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E4D2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565876454;
	bh=8fkos3bJ03vfzr91v3bkBePjiTgQUfL0AC+nbnlTyX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1yhKj8A4g0wd1345j+si7cmbl5qKNpr656Q0/Xx0MDTBRW0n2AXmoXh7MKIABfIxM
	 dQISn9+aFeZDiKun3WagevXd4NLzCjwniCYhBktEMwVnR8lXhtzKY37qLT/tRe8F7D
	 1j/x3AnyTUS7bv2UUaQcQ7F/gAK6xm8co9WN9oRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbfHONkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732267AbfHONkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:40:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF5F7206C1;
        Thu, 15 Aug 2019 13:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565876452;
        bh=8fkos3bJ03vfzr91v3bkBePjiTgQUfL0AC+nbnlTyX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GaOhF6vbyf+T7aulWg92TMC6bUDvEbaPxwD2xqLBCY4CHHdPDRWT9gjWEDCpwNFt7
         QWxfcdLHp1h0+mTzJ+LulblqiIx4HaWbkhXARaJs2a3K06CdvLBjy+BiEDHMruilXF
         YsizqWrmueY4Bb4qqkAyMln60GbfTZ1pf47HE0k0=
Date:   Thu, 15 Aug 2019 15:40:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 11/13] serial: lpc32xx: allow compile testing
Message-ID: <20190815134049.GA3372@kroah.com>
References: <20190809144043.476786-1-arnd@arndb.de>
 <20190809144043.476786-12-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809144043.476786-12-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 04:40:37PM +0200, Arnd Bergmann wrote:
> The lpc32xx_loopback_set() function in hte lpc32xx_hs driver is the
> one thing that relies on platform header files. Move that into the
> core platform code so we only need a variable declaration for it,
> and enable COMPILE_TEST building.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
