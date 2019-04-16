Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D563CC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A822E20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555440376;
	bh=O2ToQI59j4lQqm8NVrviT7CVqvfThcRWeuRDr5icuOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tVClxo1OLt2Io31kBzieNqoG40VfgrMtuwgYLBAB1VzT+33xeO56VIFPQP9RFMkm/
	 l7qslNhIw/XiVbTHJ7hfq4mj1UaJsyWoyIQZHPoqMBGG9dbxUAYCiYcxowZ/2aUqjI
	 cZa0O/7dys4OTMqUa59LxaANygqlVH0VZGlzjuNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbfDPSqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:46:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729640AbfDPSqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:46:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 669DC20868;
        Tue, 16 Apr 2019 18:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555440374;
        bh=O2ToQI59j4lQqm8NVrviT7CVqvfThcRWeuRDr5icuOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1MbOiQP5C2ExoHb7CK31PYqSgcNPHtKjxzY28UnAA6ELdTxZJV1+X9r9YESZfh8U
         WNwju0whP124jwiUQGNE+ooHUgy5bXcBwtwPDYJjWx0BkxJv8R38yx9/sM0d13SMBx
         sKh315HmGau319S2yulQby0QbeKqTuDeRutHF4cc=
Date:   Tue, 16 Apr 2019 20:46:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Diana Madalina Craciun <diana.craciun@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.9 20/76] powerpc/64: Disable the speculation barrier
 from the command line
Message-ID: <20190416184612.GC6253@kroah.com>
References: <20190415183707.712011689@linuxfoundation.org>
 <20190415183712.869759410@linuxfoundation.org>
 <VI1PR0401MB2463835B1223FDAE2EFFCD43FF240@VI1PR0401MB2463.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0401MB2463835B1223FDAE2EFFCD43FF240@VI1PR0401MB2463.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:43:40PM +0000, Diana Madalina Craciun wrote:
> Hi,
> 
> I have tested the patches on NXP platforms and they worked as expected.

Wonderful, thanks!

greg k-h
