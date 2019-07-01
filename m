Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6114C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881C1208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561971792;
	bh=4hVp4xkK7D3D4jFp35USuOqD5Kwe0mKGVAbEGPSmMHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=juRBzAw7JoVoae7TMeXhOe7RJ7s20zeRBR41xB5Sik4K1TaB2TuJtLrD4idfwT8/x
	 gaBTm/YupYvROUL6SdPUlrpQPahRKi2VPTpTUKz8Y6xL2mB+75+rZ7NmtnwMiG5A3Y
	 cUZSe4DnuDsoIgVa07l4em0dTasHVqNcMBWELJQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfGAJDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbfGAJDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:03:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D35E5208E4;
        Mon,  1 Jul 2019 09:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561971790;
        bh=4hVp4xkK7D3D4jFp35USuOqD5Kwe0mKGVAbEGPSmMHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EAeCMilwrbgWlQ9VdGd/VFq5E6A2azOPs0YEfMxliSdxVSEsc1a4pnQ01gquawRad
         86uNeM943piRDRAyCIUirJbbzBv8QYGmdVtVsBLgNw0cbmR10MfZc0lu9dKIdHc7xm
         9TKGhPlY87WRIRTcbF1Ku17WH3QC1ClRIbIHSTDk=
Date:   Mon, 1 Jul 2019 11:00:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for v5.3
Message-ID: <20190701090018.GB11465@kroah.com>
References: <CGME20190628013007epcas1p405af6ef75a8164072459694c2b17385a@epcas1p4.samsung.com>
 <d312e5b6-3faf-ad5e-fc2e-c6f8b09ea9ec@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d312e5b6-3faf-ad5e-fc2e-c6f8b09ea9ec@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:32:45AM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.3. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> [Detailed description for this pull request]
> 1. Add new extcon-fsa9480 extcon provider driver
> - It is extcon provider driver for Fairchild Semiconductor
> FSA9480 microUSB switch and accessory detector chip which
> detects the kind of external connector like usb, charger,
> audio, video and so on.
> 
> 2.
> - Add the exception handling code for extcon-arizona.c
> when using the regmap interface.

Pulled and pushed out, thanks.

greg k-h
