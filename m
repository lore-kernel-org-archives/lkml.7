Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7020DC3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B2C22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="cjO6zdAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfHUAjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 20:39:45 -0400
Received: from sonic311-32.consmr.mail.ir2.yahoo.com ([77.238.176.164]:46204
        "EHLO sonic311-32.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726257AbfHUAjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1566347982; bh=dBz1oFdgnI/WKEGr74peQBzy6c6LbhKbyJcmv8I8LL8=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=cjO6zdAgZdoP/eR+2UwDbg4EHc7L79a8eHYvW6+PLb3NU/onSAymNusV/OQtMwCdgAbGu5Vel7ABoJcwS6+KQz1nyRlW9+33t3I2ykkDehqpkjh/5NyI/t2YcN29kXf/8yj5rn9sOmkevQCPukD78x8F2gAHfvNU1j8V/N2n+haZrDJPGs4ZzN41c7H0yop1x1p3N2pFo2M63WyW+SfVU00T2fO+FXxJ6vnbSdHQPfQWPlwerb4LADYF439OBOZ+alPE5Rpou+tauQWpUIs426kvr/JImM9FNO6IQ2R/1+C4/Gy32yvkfqotGbwpwvg86dVmqI/ipBzoluoWhoZIgw==
X-YMail-OSG: .HtFFrsVM1m6qxT_kGxPkFMO1nJ9npRODAPvKCtCYnCvOjsoN7lJpSs1yEh.JlM
 aPvjkilVSpUpBTe5FhGM8myRDj9y.Hvt_abptFP16G3ycLR7ZZqLfAZ081TXy876P5x5gpDFHqUg
 NBgUHnR8BpFeMmpkQtuMEYrrFqdHQfAENM2ocH0_kFhlKFwvoWGMHEmy6zOHDPQPi0onR4v0Irtq
 4zgYalI0OBZckbpn8mwd_RHYHhXItkFXFeh6lP8Oz76AgklOps0zvr7M0JHxWx6JTu_ZoTevUEN2
 _kEcHBfYgeXIRubAXkkml6.2QCTRfE657BNliFnClP9w1MxKJnLx0X0vA8EnN0VTPAnb5euUsMF8
 ODxliNVZ4lAmzKF6bgN9cm_EnYLzMHPyfITaKR1BhWMAagitSIp2tPETh_oGT5ayeVQbMy7MjXoy
 di5mEQ1ylQDST6CIzUQdo2o.oIa7keucoLL3xSUfshKFE60X4k9k50naVkDd4nVQJ7HmmgkA8YfI
 VWAZCOfT_iZ7_XtaEX1fYeBEAoIwiA0ZDEwazERPEoeTrX.bPi88cvmz8BehOPH3PbX4eL7llnSb
 ZEd3Uspd_.e8q.Eje1VH2AYPCWBDApMbc9c.kbjPeGR4gLDbMh7hegEDg6.vzNj.XHi3vNJHX.29
 apPZdMfViWtU1NryPvxpdLRxjxqqnI4eRMhW6UpiUW1gMc4WCwcXF6v7H4jnxXTtt1WSnCXob35g
 ytGIEE4qlzGnf5mddo7ivWrxcnwAUupipJGQDG0BLICWlRO3nAB8AcuHuzMNkQjPTEwiwldVRkcO
 c4UAty8MlhFte0CHpjrMBNdcyZa27aFrDXs_vgGV.fi47p7xI.AQ3hivjzAbLV0rTvDh8bGSfp_Y
 Ryqyq42K1YaxcCdHqdSKKXEZ5aiDDK_3gRk1v.aRfwBTmCL.0NlDSxJg19.ZtpntYAi.8DFzgnmB
 IZARlJBF5VjRT.uYAL44vnJlsCqsyNFcK.L8n6TirJ36gkee1R4IpVJttouwH1gLfeEGlCrszUFK
 r9HRz3fGS7moHe7LClIpSyrmf8aousPS8ef8MTHyKXO9MfpzAeJD9hwCo4Fjzywa3w9PE.Jt3709
 _AgVoV6UW.xTAzjPcIrWNpCkRLGPhILlKYU10jk8s8jMLDxnE2RoNgnkEvBJGrceEnFnr1JHZ2zZ
 66ZxHV9SXHbKAsGZQ3MVLeXSmmI9pADk.a2nJ3.BnTdho6UpQCz2BDCGpO1gH_7RwpX7X2CDya2x
 CHgJHxvKyVJxWWZnSJbbQ_YBMroxGTak-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Wed, 21 Aug 2019 00:39:42 +0000
Received: by smtp405.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 79fa87127151e4dc10a6f5a22ec543fa;
          Wed, 21 Aug 2019 00:39:36 +0000 (UTC)
Date:   Wed, 21 Aug 2019 08:39:29 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Caitlyn <caitlynannefinn@gmail.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Submitting my first patch series (Checkpatch fixes)
Message-ID: <20190821003717.GA18606@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Caitlyn,

On Tue, Aug 20, 2019 at 08:18:18PM -0400, Caitlyn wrote:
> Hello!
> 
> This patch series cleans up some checkpatch fixes in erofs. The patches
> include balancing conditional braces and fixing some indentation. No testing
> done, all patches build and checkpath cleanly.

I think you need to work on the latest staging tree or linux-next.
This patchset cannot be applied (there is the only valid place in inode.c,
I will reply in the following patch.)

Thanks,
Gao Xiang

> 
> Caitlyn (2):
>   staging/erofs/xattr.h: Fixed misaligned function arguments.
>   staging/erofs: Balanced braces around a few conditional statements.
> 
>  drivers/staging/erofs/inode.c     |  4 ++--
>  drivers/staging/erofs/unzip_vle.c | 12 ++++++------
>  drivers/staging/erofs/xattr.h     |  6 +++---
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> -- 
> 2.7.4
> 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
