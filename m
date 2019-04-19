Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15609C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1662171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfDSVuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:50:08 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:40967 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfDSVuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:50:08 -0400
Received: from [192.168.1.164] ([37.4.249.100]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MBUuP-1h7TQv0yY3-00Cz70; Fri, 19 Apr 2019 23:49:50 +0200
Subject: Re: [PATCH] Staging: vc04_services: Cleanup in ctrl_set_bitrate()
To:     Madhumitha Prabakaran <madhumithabiw@gmail.com>, eric@anholt.net,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20190419212321.7325-1-madhumithabiw@gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
Message-ID: <2d48664a-eb36-4fcc-7bc5-b1b480dbce9a@i2se.com>
Date:   Fri, 19 Apr 2019 23:49:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419212321.7325-1-madhumithabiw@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:X7GVbpZeg6xHEvo9dwFMGWrzQ1nzrxaJosD6YyVtVZNvg5uAitG
 LYFuu8NZG7HNHLKMtRxKcE21f2GEgohpIXzyN7GU6B+HsviCbpf20SCy02+Lnq+Rm9fEIJZ
 l1hFGQiSASoWh4BAaVKjfo2qytCF4WQoopsgHCCcj5jx0kedtgO6fU/kymNRQoZ+bfMk2eh
 7Rd46DcThOvMkWUxXTl0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CYimwQ28WDM=:U4/tNwKiv6GI6LCVUvOesx
 GFcX88jNMBfkectoX+aVSnFDzdBvqvvcUVI56sfZ+GdZB4FTC7sEH0clmqVP4kDlL+G18qahR
 k0Opivq0CjkFUiABpGSiMbYoZHSCvRQlL8ty5gCN697LaMuTdhxnYRYb2n/kRE7bUHv/NnAgJ
 8rHoYEEKUrvspb0K5P/TocJUyG9Qlft94b1Kld/a8BPRVN7rYtYP/xtdKBIN97FXaUB7Vc91Q
 8ShmU4+LESvTbv/ABdbo+au55U4cCurEa5hgunjfFw8dRDoy+Z9aNkBUKpRvoNiV5HTfvb57F
 +FYxcDPQy+FtQrtDn+2u5pdaEBJwMMKpG4xQ76xFTJtPYwHvTw+tyLFAULryG0bfqUy7bmkf9
 j/xlyyhO3hdeswYGwfunu7Zij0UtYAqTEOsCbvL6+Idm8OKXQBu+AfRMu0NkKKwSKrk5/OdPW
 59go8r54aYENlY+R9s49QW8WjJ6a9Ajzd0XgYdzAeTrw7l8d+9+ID5SCGytTR4amzoWqAPYbp
 9YFoVBew9t46xGubQuJLr513imbCBGAIsCNks2uqMTh4miGencBYb+AmNwvVnKwXOU+I++m88
 1lNllm6V8SYStaBZhEDrREYXyQLIN8Jm2lQ6+rTcmWYirqZ3nUA5AGcOLQVDcu7xEL3N3Z15P
 hd+NODE1MyFKNe23i0QaJXrGp8gj1MnMPcCQVI+318x5NUzdIdEMGlzBIsLzq+3cQ7OBFmYUu
 iQ0d1mQerYJAfcOh920oRLRZQTusWw8OUypjWGYj3cn66pTgg5b1mmSz9QM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Madhumitha,

Am 19.04.19 um 23:23 schrieb Madhumitha Prabakaran:
> Remove unnecessary variable and replace return type.
>
> Issue suggested by Coccinelle.
>
> Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> ---
>  drivers/staging/vc04_services/bcm2835-camera/controls.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> index e39ab5fae724..f87fa7f61db3 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> @@ -607,18 +607,13 @@ static int ctrl_set_bitrate(struct bm2835_mmal_dev *dev,
>  			    struct v4l2_ctrl *ctrl,
>  			    const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
>  {
> -	int ret;
>  	struct vchiq_mmal_port *encoder_out;
>  
>  	dev->capture.encode_bitrate = ctrl->val;
>  
>  	encoder_out = &dev->component[MMAL_COMPONENT_VIDEO_ENCODE]->output[0];
>  
> -	ret = vchiq_mmal_port_parameter_set(dev->instance, encoder_out,
> -					    mmal_ctrl->mmal_id,
> -					    &ctrl->val, sizeof(ctrl->val));
> -	ret = 0;
> -	return ret;
> +	return 0;

i don't understand why we can remove here the function call.

Stefan

>  }
>  
>  static int ctrl_set_bitrate_mode(struct bm2835_mmal_dev *dev,
