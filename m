Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428D6C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8422512B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559564314;
	bh=7qoawnvievmUO6isD6QoKKaHpyd2SkSq+1tZy06rUJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nB+HT73kZuzF5k1N2blpBXBQbFGPph/c/keId9o8hpnLwJ5DYAlfX6avKICCwKaue
	 7imW254idghrto7ir4I0KAuvzrgaK76QvquCssoIRzDoKymf7Hht+fIA9s3WyztgBC
	 WnxkbjBHNWUH6LvPc2gIwp1a8w2y4z3g0ILX4m38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfFCMSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:18:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbfFCMSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:18:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B90CA24460;
        Mon,  3 Jun 2019 12:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559564312;
        bh=7qoawnvievmUO6isD6QoKKaHpyd2SkSq+1tZy06rUJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w9cIKuarGmTB/vumIH6h8RGV2B9GhCvFWF6k7aHrTqV7OGrV9FF+zLsKdNQIjw64G
         6RER/7FQsLKgWrc13SuYXWzAaQegl21XiPVNQGwtrmZNwXtB+x43AmiAHoe8QwleAQ
         fouYyVglEHTnbFXdkuTmRtumXuvQv2VTBtUAgULo=
Date:   Mon, 3 Jun 2019 14:18:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        himadri18.07@gmail.com, colin.king@canonical.com,
        straube.linux@gmail.com, yangx92@hotmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Replace function
 r8712_free_network_queue
Message-ID: <20190603121829.GA15705@kroah.com>
References: <20190530205755.30096-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530205755.30096-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 02:27:55AM +0530, Nishka Dasgupta wrote:
> Remove function r8712_free_network_queue as it does nothing except call
> _free_network_queue.
> Rename _free_network_queue to r8712_free_network_queue (and change its
> type to static) for continued use of the original functionality.

You did not change the type to static:

> -static void _free_network_queue(struct _adapter *padapter)
> +void r8712_free_network_queue(struct _adapter *padapter)

:(

