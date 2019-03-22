Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC862C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 02:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9DC21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 02:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553221304;
	bh=NZvRNzkBrbkVXVj9HPL2ETR2BYNaQpUEIaBGENh6ay8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=du7Q60vuzAjvBslbt1fafD35NIexPpeJV/FBMWRS+cIWcF18Jn7/rvzabINBNB0dy
	 h+EDdD+1A4WhEz2+AH7SIHtAPPk9KAnJpGfG1YPuJLHtuUYlCFgizQdWYzAZ/mEde1
	 hDws/B+yt5x2TxAa1T8yQtBZG4/bIGrftiteIJHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfCVCVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:21:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfCVCVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 22:21:42 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07532213F2;
        Fri, 22 Mar 2019 02:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553221301;
        bh=NZvRNzkBrbkVXVj9HPL2ETR2BYNaQpUEIaBGENh6ay8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ozvj1B+g0tL3bwxcmBwZePkluHO8aKFxsmvYPvPziRj49UmLnLNdiqYdUONthyfSS
         UoEj2QNFUml53DGvY9KXhHhsPgrK/Hnji2RYqDXK/zA7g1fYU6JB8uIWUnYVS7ohkA
         vKziRluUoRCXRLFRPiD3kIjqNfcyH0XDrHx41ojA=
Date:   Fri, 22 Mar 2019 10:21:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ARM: dts: ls1021a: Remove unused properties from
 QSPI node
Message-ID: <20190322022114.GA12513@dragon>
References: <20190320143800.3555-1-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320143800.3555-1-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 02:38:02PM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> After switching to the new FSL QSPI driver the properties
> 'fsl,qspi-has-second-chip' and 'big-endian' are not used anymore.
> 
> The driver now uses the 'reg' property to determine the bus and
> the chipselect. The endianness is selected by the driver depending
> on which SoC is used.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied both, thanks.
