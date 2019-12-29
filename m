Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B91C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 22:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1877207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 22:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfL2Wwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 17:52:46 -0500
Received: from smtprelay0194.hostedemail.com ([216.40.44.194]:51805 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726416AbfL2Wwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 17:52:46 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BE386348D;
        Sun, 29 Dec 2019 22:52:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: play68_8c3e37cc6c84a
X-Filterd-Recvd-Size: 1615
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sun, 29 Dec 2019 22:52:43 +0000 (UTC)
Message-ID: <1ec873d6df7de91c972fa356eb33d65437a3e67b.camel@perches.com>
Subject: Re: [PATCH v3] Staging: wfx: Fix style issues with hif_rx.c
From:   Joe Perches <joe@perches.com>
To:     Matthew Hanzelik <mrhanzelik@gmail.com>,
        jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sun, 29 Dec 2019 14:51:58 -0800
In-Reply-To: <20191229223142.5pxmmu7sfwdtcn7d@mandalore.localdomain>
References: <20191229223142.5pxmmu7sfwdtcn7d@mandalore.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-12-29 at 17:31 -0500, Matthew Hanzelik wrote:
> Fix the 80 line limit warning on line 79 of hif_rx.c.
> 
> Also fixes the missing blank line warning on line 305 of hif_rx.c after
> the declaration of size_t len.
[]
> diff --git a/drivers/staging/wfx/hif_rx.c b/drivers/staging/wfx/hif_rx.c
[]
> @@ -76,7 +76,8 @@ static int hif_multi_tx_confirm(struct wfx_dev *wdev, struct hif_msg *hif,
>  				void *buf)
>  {
>  	struct hif_cnf_multi_transmit *body = buf;
> -	struct hif_cnf_tx *buf_loc = (struct hif_cnf_tx *) &body->tx_conf_payload;
> +	struct hif_cnf_tx *buf_loc =
> +		(struct hif_cnf_tx *) &body->tx_conf_payload;

Just get rid of the cast instead

	struct hif_cnf_tx *buf_loc = body->tx_conf_payload;

should work fine.


