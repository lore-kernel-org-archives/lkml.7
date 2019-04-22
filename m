Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659F2C10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 01:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D85C2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 01:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555895807;
	bh=nWDDTriAaRe8hRAPjiq8CbyMD1BWfWokKdGAQCcP7Uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=suUzhwr3DeCTMYakmzK7PfcDe/12q0jdCWCLLj2f8m2VM4q8XtLuv49UGlgnvUkTk
	 9jhNWxXy0bxuMk+uwZeKg+rnORemn7yrLkz5feEw5xY/g3q1mnt5y/I6XUDblRMWuF
	 w+iFs+pgSZf3vM2HLbDGJS/WfsCYx5vJjAYamH1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfDVBQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 21:16:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfDVBQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 21:16:45 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDDAA2075A;
        Mon, 22 Apr 2019 01:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555895805;
        bh=nWDDTriAaRe8hRAPjiq8CbyMD1BWfWokKdGAQCcP7Uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HyFVMnYA2ZTH9Ya2eLld8yBh0YBAGTaqU01awUWlImmSmg+ShLqytw6ZTVVju9mjB
         9XyWt+fY8Bvyferyf5OBSdFnPng8EXnzFDAF1YiI2+WHY2WXLvEQAbkjBarJzGzzvc
         v5c2ZS5Z8Q0FEgNBk5CQ9IPkfXRfKjUP5MpvmXBw=
Date:   Mon, 22 Apr 2019 09:16:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: vf610-zii-dev: Mark i2c0 SCL as
 GPIO_OPEN_DRAIN
Message-ID: <20190422011629.GM19962@dragon>
References: <20190414183558.25750-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190414183558.25750-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 11:35:57AM -0700, Andrey Smirnov wrote:
> Mark i2c0 SCL as GPIO_OPEN_DRAIN to fix the following warning:
> 
> gpio-36 (scl): enforced open drain please flag it properly in DT/ACPI DSDT/board file
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-kernel@vger.kernel.org

Applied both, thanks.
