Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B18ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 05:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DB42082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 05:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbfJPFNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 01:13:53 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:65174 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726552AbfJPFNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 01:13:52 -0400
X-IronPort-AV: E=Sophos;i="5.67,302,1566856800"; 
   d="scan'208";a="406361704"
Received: from ip-121.net-89-2-166.rev.numericable.fr (HELO hadrien) ([89.2.166.121])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 07:13:50 +0200
Date:   Wed, 16 Oct 2019 07:13:50 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Jules Irenge <jbi.octave@gmail.com>
cc:     outreachy-kernel@googlegroups.com, eric@anholt.net,
        wahrenst@gmx.net, gregkh@linuxfoundation.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: vc04_services: fix line over
 80 characters checks warning
In-Reply-To: <20191015225716.10563-1-jbi.octave@gmail.com>
Message-ID: <alpine.DEB.2.21.1910160713140.2732@hadrien>
References: <20191015225716.10563-1-jbi.octave@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  #ifndef VCHI_BULK_GRANULARITY
>  #   if __VCCOREVER__ >= 0x04000000
> -#       define VCHI_BULK_GRANULARITY 32 // Allows for the need to do cache cleans
> +#	define VCHI_BULK_GRANULARITY 32 // Allows for the need of cache cleans
>  #   else
>  #       define VCHI_BULK_GRANULARITY 16
>  #   endif

The branches should be indented to the same degree.

julia
