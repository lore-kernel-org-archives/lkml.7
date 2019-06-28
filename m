Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A45C5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C499E214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561762537;
	bh=kIUly98/abHLrDwCWp4BUJhyZ2mlDdcyKyA9sUivkSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ocolOQKiav+fpp2eLQld/chPONAFIv/QngTrgi03XpJWFeZIGaMD7Xvx70aVAuGTD
	 f5RIR0gnU+19SDgxejSK1Act7QM1/jNPhGF0D0swQ/e5Vqysczn21w1v1yIx8Luz5j
	 si94Bbok0k5xp46Mmu2X7N214tov53RifOHh/NrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfF1Wzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 18:55:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbfF1Wzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 18:55:36 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 294082086D;
        Fri, 28 Jun 2019 22:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561762535;
        bh=kIUly98/abHLrDwCWp4BUJhyZ2mlDdcyKyA9sUivkSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wVvmhKl+g08YzyG46XVfg5LuZNia1qQiQ+ASouU6FvvY4YA5mZQraPNeIczvyi9+8
         tXz6V0vJZ8hm/8liYtFASLimcSVoXcMDQKB+ZK5WC7OTlilgWg1mSepNTWKqSvoCsi
         7N9TzfD6p+QFxogm3crRjw7xgSZQgMCdSZJKqy40=
Date:   Fri, 28 Jun 2019 18:55:33 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Elsasser <jelsasser@appneta.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: net: check before dereferencing netdev_ops during busy poll
Message-ID: <20190628225533.GJ11506@sasha-vm>
References: <CAGnkfhxxw9keiNj_Qm=2GBYpY38HAq28cOROMRqXfbqq8wNbWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAGnkfhxxw9keiNj_Qm=2GBYpY38HAq28cOROMRqXfbqq8wNbWQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 06:34:58PM +0200, Matteo Croce wrote:
>Hi,
>
>Is there any reason for this panic fix not being applied in stable?
>
>https://lore.kernel.org/netdev/20180313053248.13654-1-jelsasser@appneta.com/T/

What's the upstream commit id?

--
Thanks,
Sasha
