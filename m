Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651CEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F85217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711332;
	bh=lpJ0iUG2IJLw6/nawZNIUXUC8iQySeOPLpQ6dIinuYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BC2Q6QlpbUbwTAAgRgxC5+3akX8xAPRxSBkkIcpaKislHEZ97v0eni2PbR+VE5uBc
	 5G/TrB453erYtZdY78woHCa/iqH5ikNGUWk6DLMc8er4U+vQiS4trZH/PWT2uJ/5U0
	 ieLZsQy1HdLUBoMQu/AFOlI+v/Ujet6ttF8aRctc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391950AbfC0S2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391911AbfC0S2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:28:39 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 445662087C;
        Wed, 27 Mar 2019 18:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711318;
        bh=lpJ0iUG2IJLw6/nawZNIUXUC8iQySeOPLpQ6dIinuYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C3ISchI3IT6qZ4yYukBsMu+Oi1XD1ZTNPkuBfhXdYXkIdsuJ1gxOeltY8Y7fSSRjC
         bin33HCJDpkKstXFhMPF4kfP/Tv32QWo8Z/9c2QT4m4xUOnE5Ac++KEOJlCjXQRIJp
         nPpgf750mS8F18MhQ6anb76hDdh/rC/Oug2TszvU=
Date:   Thu, 28 Mar 2019 01:49:22 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     robh+dt@kernel.org, linus.walleij@linaro.org, lee.jones@linaro.org,
        mark.rutland@arm.com, afaerber@suse.de, treding@nvidia.com,
        david@lechnology.com, noralf@tronnes.org, johan@kernel.org,
        monstr@monstr.eu, michal.vokac@ysoft.com, arnd@arndb.de,
        john.garry@huawei.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, jan.kiszka@siemens.com,
        maxime.ripard@bootlin.com, linux-kernel@vger.kernel.org,
        linux-netdev@vger.kernel.org
Subject: Re: [PATCH v9 0/6] Add Fieldbus subsystem + support HMS Profinet card
Message-ID: <20190327164922.GA12063@kroah.com>
References: <20190318180338.23964-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318180338.23964-1-TheSven73@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 02:03:32PM -0400, Sven Van Asbroeck wrote:
> This patch:
>   1. adds a Fieldbus subsystem
>   2. adds support for the HMS Industrial Networks AB Profinet card.
> 

<snip>

Can I get a follow-on patch to add a TODO file to this directory in
staging saying what needs to be done to the code to get it out of
staging?

thanks,

greg k-h
