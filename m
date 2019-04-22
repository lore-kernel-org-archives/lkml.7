Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE85C10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 01:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EE520859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 01:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555895050;
	bh=zM1s/54yPVnWsT48H6n1WnVU0oV6xtr00/l4CRfStEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B4b28N/R1GyMNj6iioSUlxOhVqjlb0tjdDmX4BNmE09p47gJS9S8iYOW4iJuZ3ATi
	 tpNeHvfByQP1CzOmDECKKM4gj24szaZ1Jilu26GCgBQIZ5Cx21Dk/rGUxGiVcJhQ3C
	 kzAG05aMR6L6PRzG9jJkPIK2cg815LzR7FlBAqr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfDVBEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 21:04:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfDVBEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 21:04:07 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0406320859;
        Mon, 22 Apr 2019 01:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555895047;
        bh=zM1s/54yPVnWsT48H6n1WnVU0oV6xtr00/l4CRfStEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ubmPg23uE40N0GutXUpVcYamHkzRJRmfrUJub9/r3YjuBzEWoKpNXCJSazLb6/s/i
         wig5los2go+17rWWEWsSVhp0ziSY3JoQTN+Jjxf5nie0/5EUOCkiW2WOj5FeX8th/y
         IHbS9MCl5tQurjiLrRZ+x45LhpceBx6BWYdj1k4M=
Date:   Mon, 22 Apr 2019 09:03:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/4] ARM: dts: Add support for ZII i.MX7 RPU2 board
Message-ID: <20190422010350.GL19962@dragon>
References: <20190414183403.21538-1-andrew.smirnov@gmail.com>
 <20190414183403.21538-4-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190414183403.21538-4-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 11:34:03AM -0700, Andrey Smirnov wrote:
> Add support for ZII's i.MX7 based Remote Peripheral Unit 2 (RPU2)
> board.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org

Applied, thanks.
