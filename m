Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC8BC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D17E21743
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565343797;
	bh=Myej1XaHJ37HBPiQb0ac9jF7pYIU1tfzoPpCO0wTV0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jBazjEAwqeFSWjv/tPCZWIf0B6vIA2akztjhoo9Y0iAT8z5Lj/4Avg8AUE7/LZ67m
	 dqBz2qjezYfQOvccNaU1gb/KPEr1ycJ5W6nn5l1z9NCRspIPrMAtGgSrAiZwkQt1eg
	 gistxnarYkYMqfVESbzti526NcnGqUWx2tXkheL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405868AbfHIJnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:43:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbfHIJnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:43:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B50C2171F;
        Fri,  9 Aug 2019 09:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565343785;
        bh=Myej1XaHJ37HBPiQb0ac9jF7pYIU1tfzoPpCO0wTV0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WnGnOucdz4Xp9sozzeiW4ZaP5DkmviSXDf6b6J2phlrcJ/K5uhs66bvAKpfYT9KMi
         Z5HezNzRhmv4f9i5frSOKJv4CZ1GnZuW0SW5xMuw/qdqY/ZFwLp+4a7u2lIvePrdIZ
         UzN4nsVp/jfhXZcuhjymi6E0dOuotK57/bbtD1zU=
Date:   Fri, 9 Aug 2019 11:43:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Charlemagne Lasse <charlemagnelasse@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Basil Peace <grv87@yandex.ru>,
        Carmen Bianca Bakker <carmen@carmenbianca.eu>,
        Keith Maxwell <keith.maxwell@gmail.com>,
        Matija =?utf-8?Q?=C5=A0uklje?= <matija.suklje@liferay.com>
Subject: Re: REUSE/SPDX: Invalid LicenseRef in Linux sources
Message-ID: <20190809094303.GA6297@kroah.com>
References: <CAFGhKbwJVv23Mwd7ruo8JCC-0U3BdNRwnxih9zgFSCyPe=jnoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFGhKbwJVv23Mwd7ruo8JCC-0U3BdNRwnxih9zgFSCyPe=jnoA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 11:30:44AM +0200, Charlemagne Lasse wrote:
> When I run the reuse lint tool on the current linux sources, I get
> following error
> 
> reuse.project - WARNING - Could not resolve SPDX identifier of
> LICENSES/deprecated/GPL-1.0, resolving to LicenseRef-Unknown0
> reuse.project - WARNING - Could not resolve SPDX identifier of
> LICENSES/exceptions/GCC-exception-2.0, resolving to
> LicenseRef-Unknown1
> reuse.project - WARNING - Could not resolve SPDX identifier of
> LICENSES/preferred/LGPL-2.0, resolving to LicenseRef-Unknown2
> reuse.project - WARNING - Could not resolve SPDX identifier of
> LICENSES/preferred/LGPL-2.1, resolving to LicenseRef-Unknown3
> reuse.project - WARNING - Could not resolve SPDX identifier of
> LICENSES/preferred/GPL-2.0, resolving to LicenseRef-Unknown4
> reuse.project - WARNING - Could not resolve SPDX identifier of
> LICENSES/dual/Apache-2.0, resolving to LicenseRef-Unknown5
> reuse.project - WARNING - Could not resolve SPDX identifier of
> LICENSES/dual/MPL-1.1, resolving to LicenseRef-Unknown6
> reuse.project - WARNING - Could not resolve SPDX identifier of
> LICENSES/dual/CDDL-1.0, resolving to LicenseRef-Unknown7
> 
> Can you please help to fix the problem

Please fix the reuse tool, I don't see this being a kernel issue, it has
never said it follows the spec put forth by the reuse project.

thanks,

greg k-h
