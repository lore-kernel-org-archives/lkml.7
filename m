Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8FDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D85520989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553489801;
	bh=zfPVppwexaRjcTxpW4dzrf9ukbsVD4Eme60yKgVqufc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ic4CFRlnotzr85YLDS1MvJz1MssEpfxTS6cYd4oVEHOYrNJVfwswhgjMLgdyuapzn
	 F99FZLgGaWP87yiwleiq9at+uXQkyWiHfMoRG58zcqLbJd4FRW9k2OUwy381JbKub6
	 Lwaalwie/ApSvFSRVfqm50peyR5ipNe0H2SoLV4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfCYE4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 00:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfCYE4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 00:56:39 -0400
Received: from localhost (unknown [171.61.95.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF8CA2087E;
        Mon, 25 Mar 2019 04:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553489798;
        bh=zfPVppwexaRjcTxpW4dzrf9ukbsVD4Eme60yKgVqufc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g7dSFOcYevpORBZUbquWtnyYAF70jcsa0DN87sgdB9uQMgZQG5gFXSjZV21rEKI1s
         D/xeEiJreuHNwHBiw76kkz2lKjebavQEFWt25ZB9ZxIQdiXcIzTf3aOdCgSVm/sepF
         sif2NQamQMuA6nZ0x6D8Ljw/CeV6mccvckxppPRk=
Date:   Mon, 25 Mar 2019 10:26:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dmaengine: omap-dma: make omap_dma_filter_fn private
Message-ID: <20190325045632.GG5348@vkoul-mobl>
References: <20190307151646.1016966-1-arnd@arndb.de>
 <20190307151646.1016966-2-arnd@arndb.de>
 <641ebb44-7278-f298-c03d-8251dcd6c71e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <641ebb44-7278-f298-c03d-8251dcd6c71e@ti.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-03-19, 16:32, Peter Ujfalusi wrote:
> 
> 
> On 07/03/2019 17.16, Arnd Bergmann wrote:
> > With the audio driver no longer referring to this function, it
> > can be made private to the dmaengine driver itself, and the
> > header file removed.

Applied, thanks

-- 
~Vinod
