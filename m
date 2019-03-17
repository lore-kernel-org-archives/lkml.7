Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FEAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B87E2064A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552822211;
	bh=83XdzFmLUa/jKS/BDwMLLaRmeKO9SdQL8cU5ANbgu7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TEwYQX6mcRSiy/CXiuyazFuwBtlv9K5c28xjE19qdKa7B+VJAZF8AyTNBdvNaTGKm
	 I8zpnGzq3NiGp4P3Gp+OOITUDuKcnJU2H2NgLKi934cpQiEupytMogu0LbYVnq6CiR
	 l8bBt8uBpRMg6vj8d0p+DjDrcf8y8D/2U9lIGw0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfCQLaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 07:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfCQLaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 07:30:09 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBBB42064A;
        Sun, 17 Mar 2019 11:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552822208;
        bh=83XdzFmLUa/jKS/BDwMLLaRmeKO9SdQL8cU5ANbgu7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O54KvVNWaH/rk85vbHsPWdGtJTp+8UGJv82R419wxWKiE7nVlyOJz9sXiPHbbStyq
         Iy3Tr9wgARjHhvAZxEnxGo/Hp5Le1LTYj12o196uE9HEmKHuPa/F2K4+OnnYy95bB2
         J/XwEn9YHdFxe29XiFvDrOyMYLdnyfIGaadW3XqU=
Date:   Sun, 17 Mar 2019 12:30:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Emanuel Bennici <benniciemanuel78@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, NeilBrown <neil@brown.name>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Subject: Re: [PATCH] staging: mt7621-pci-phy: Add Spaces to Macro Definition
Message-ID: <20190317113004.GK4614@kroah.com>
References: <20190317002345.GA6938@p200300EEEE2F.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190317002345.GA6938@p200300EEEE2F.fritz.box>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 01:23:48AM +0100, Emanuel Bennici wrote:
> Improve Code readability by adding Spaces after #define

You did not add "spaces", you added tabs.

Please be specific :)

thanks,

greg k-h
