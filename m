Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22839C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 08:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3FC21743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 08:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="Iwr3Cs2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEAILM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 04:11:12 -0400
Received: from sonic317-55.consmr.mail.bf2.yahoo.com ([74.6.129.110]:33532
        "EHLO sonic317-55.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726022AbfEAILM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 04:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1556698270; bh=Y2dHOET1wsukHphaUpBUg3ZJmm3iLOlC79FvnUDGATo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Iwr3Cs2vnCLXqwuJcLFrTtJi9D5feFdQ4OvdmKz12h6W8YAjvazLv+sljuU8NLJwKRz2HwXv0EqEJ3warnxoZqnpEEVZe8vp3mUAiZ4oh5oIOsZwg4x2BEziJwKCdcxQViOzGcuZ9OvcKXoTQjpJ9TQquc4jLGR2x8ho2giXPJ4gyomxtrSahtmEYqizcFbjlWCxi9mY1gyAzjzRQGRLznlBlvY4u7ELN/S2pXtszZEHusUWhAxhdvBlfFivYmp0AoEG6hP+f6NE1LC8H+hid+qlgLg8jTtty71wohNEi0V1fxPVqIdnFRK4x10ha1F5uxpDQwoBFdkMiVYWVoEEJw==
X-YMail-OSG: 2rrnJ.QVM1koCGyqZVLrE.lIGmouJzP82.MxT_3Mt8TCIW5KhE1lOIlRr9zTD8z
 bjDPQkFPmriu7kk5kJYFBSN7vH5EPgdSWEyCsdr7Q_kfFg3VrJjvON74KtvXZg0hLcsDrDRKyYXI
 m0jxyDHPVeEAvfNuTOSK2YdxMS6kBO0SNzsuwYzQR_GIwwhn4N5MKLKmrowlN7CGyM8Eqsvggqv1
 hNf_CEe0xMsLRjzu290lxvcdvJC6JPd6Z3lMBHfAtisQP_HCj8SEuAa0Q2XSBZfKXgNLoCVdRVdD
 qhjqnxgTFk08oiMg735XRdupNwC_8MwPHl0Qv0a7ww3ozg8w.pkaJ0opuFj35zU9N76uAww1uTUB
 xSdBnEc7hPP1Qy.W.QmYQF1Xxr9VU56iv7S_GTN_GBlp_S.XJ9ykbS0m1CZCm63fSZo7aBBMhSrJ
 BsZAIjSQR.1_sZvIH2L8sYwdqebSZ6nMMxffnicwmJMPr1LUukg1gl1aa_0A45fKIKjGPe_DLXse
 ItQxL8Hxm3Z1gvBhT82_jhvT.VpXSzkIekYVYo9wJ1a4u_214SBfglaOwRcde3ZRW5tG_zwkiDXs
 WARcwN0zvm2R0hYYSTPYOqCadLvO_4x2yBU.jGGYdmSttbbobbhGSSO4EuxrnGkBWWXtnjmETDLZ
 5NN0rYC8LY644gILCkKN6.N3Si6HWeLILxbMK2nkd5OomJmLA2UjDJufPRiRb.XFL1ruwxfocycR
 gNq2kFjT7nEbm8NTEvOKGAiLuj6mpWhgLbWV9JDdYyLGz4F10qlsTtMYI2aIADKh0Ky6m3CNoJVJ
 8lnPh84HLJqoDnhLG31JAOEK.EjCfWnK_V1DbOrIamLhcoB7GBmxdo39EreYilyRnWhcW3F_FwLS
 LcVj0qfgO_uPFVeT_Jt7FJQWF.1D6Wv7iBOuNzXKffxqhidtXwaUKK2grbWcjfyXv19so5jDpLO2
 Zy_wK_ry1JMZy.WrincmWH.UPUqZfMeB0vkTUBI9pXk9q2V70TtyrKjGwDmOyQ1BNz13cT04jO9D
 oJZcfQefH6.EoVq38t5Q75xGcH4FxZPhsBuu19arVK_gdN3CPgLWsxOyu2Wgm7iqQSMWe197rfXz
 ZgQDrw5BKVeKLEXW.MtSBblnq_MtXXDkV7zSFuGEy1wstFYy34keUiQl3zKY5QHPCkWpweL9pWfW
 CzDHzRwbVq5T9NAlRZtv_gRTFmp6seDzVqkmlSFaisDodhlN7kld3ti45kvFK18J8qZ0hZx8r75_
 MuLgEQ.vWFogbqCZiwFoDiZ4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Wed, 1 May 2019 08:11:10 +0000
Received: from adsl-173-228-226-134.prtc.net (EHLO [172.20.4.247]) ([173.228.226.134])
          by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ea83374154492caf1b6f366f97407823;
          Wed, 01 May 2019 08:09:09 +0000 (UTC)
Subject: Re: linux-next: manual merge of the staging tree with the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Gao Xiang <gaoxiang25@huawei.com>
References: <20190501170528.2d86d133@canb.auug.org.au>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <a118d56b-fd0f-1d2d-dd82-b6f16881e0cd@aol.com>
Date:   Wed, 1 May 2019 16:09:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501170528.2d86d133@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/5/1 ??????3:05, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the staging tree got conflicts in:
>
>    drivers/staging/erofs/data.c
>    drivers/staging/erofs/unzip_vle.c
>
> between commit:
>
>    2b070cfe582b ("block: remove the i argument to bio_for_each_segment_all")
>
> from the block tree and commit:
>
>    14a56ec65bab ("staging: erofs: support IO read error injection")
>
> from the staging tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
the patch looks good to me,


Thanks,
Gao Xiang

