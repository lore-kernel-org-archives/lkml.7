Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A33C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A989C218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551389665;
	bh=0OfZ6HPE3TFlBTU+uT/JNv9Pnt8hPT0mIyPf/IdPvbo=;
	h=In-Reply-To:To:Subject:References:From:Cc:Date:List-ID:From;
	b=xNUWLUDtugTTTnhOYSHvGEGZiyKcbviMhX4zrp1Q2QgPOEbKFhowNhUk0L21Qf2S1
	 eAPP2NxgjJW87yIaRJs5G5v7TbwQ+x9hZBzUygEdxOi18jxI9988EzE/l0VBHODwsO
	 Xr0zXoW42hkKX41bQeYy1a04Hst/4IC43dukfrLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbfB1VeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:34:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbfB1VeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:34:24 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF4C218AE;
        Thu, 28 Feb 2019 21:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551389663;
        bh=0OfZ6HPE3TFlBTU+uT/JNv9Pnt8hPT0mIyPf/IdPvbo=;
        h=In-Reply-To:To:Subject:References:From:Cc:Date:From;
        b=PK/HCWlMtLi/q4/HQQpvIUKZ3vuReJ94NsJFxRuqeMXJlTnfzlmpS8VAm6aETgewU
         wkLc6OakEco6aq9dBjQp2DIMvLyt+p8F7dXuCgOH7IzUehdB09E0xWGLPH/GgDoUkA
         BvBOo8qHFuXRmTdTag/+98uI515LrcTeEaiPRS68=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190225065044.11023-6-vaishali.thakkar@linaro.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>,
        andy.gross@linaro.org
Subject: Re: [PATCH v4 5/5] soc: qcom: socinfo: Expose image information
Message-ID: <155138966250.16805.8149986906489473683@swboyd.mtv.corp.google.com>
References: <20190225065044.11023-1-vaishali.thakkar@linaro.org> <20190225065044.11023-6-vaishali.thakkar@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
User-Agent: alot/0.8
Date:   Thu, 28 Feb 2019 13:34:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vaishali Thakkar (2019-02-24 22:50:44)
> +                                               qcom_socinfo->dbg_root);
> +
> +       DEBUGFS_IMAGE_NAME(name, apps, SMEM_IMAGE_TABLE_APPS_INDEX);
> +       DEBUGFS_IMAGE_VARIANT(variant, apps, SMEM_IMAGE_TABLE_APPS_INDEX);
> +       DEBUGFS_IMAGE_OEM(oem, apps, SMEM_IMAGE_TABLE_APPS_INDEX);
> +
> +       qcom_socinfo->mpss =3D debugfs_create_dir("mpss",
> +                                               qcom_socinfo->dbg_root);
> +
> +       DEBUGFS_IMAGE_NAME(name, mpss, SMEM_IMAGE_TABLE_MPSS_INDEX);
> +       DEBUGFS_IMAGE_VARIANT(variant, mpss, SMEM_IMAGE_TABLE_MPSS_INDEX);
> +       DEBUGFS_IMAGE_OEM(oem, mpss, SMEM_IMAGE_TABLE_MPSS_INDEX);
> +
> +       qcom_socinfo->adsp =3D debugfs_create_dir("adsp",
> +                                               qcom_socinfo->dbg_root);
> +
> +       DEBUGFS_IMAGE_NAME(name, adsp, SMEM_IMAGE_TABLE_ADSP_INDEX);
> +       DEBUGFS_IMAGE_VARIANT(variant, adsp, SMEM_IMAGE_TABLE_ADSP_INDEX);
> +       DEBUGFS_IMAGE_OEM(oem, adsp, SMEM_IMAGE_TABLE_ADSP_INDEX);
> +
> +       qcom_socinfo->cnss =3D debugfs_create_dir("cnss",
> +                                               qcom_socinfo->dbg_root);
> +
> +       DEBUGFS_IMAGE_NAME(name, cnss, SMEM_IMAGE_TABLE_CNSS_INDEX);
> +       DEBUGFS_IMAGE_VARIANT(variant, cnss, SMEM_IMAGE_TABLE_CNSS_INDEX);
> +       DEBUGFS_IMAGE_OEM(oem, cnss, SMEM_IMAGE_TABLE_CNSS_INDEX);
> +
> +       qcom_socinfo->video =3D debugfs_create_dir("video",
> +                                                qcom_socinfo->dbg_root);
> +
> +       DEBUGFS_IMAGE_NAME(name, video, SMEM_IMAGE_TABLE_VIDEO_INDEX);
> +       DEBUGFS_IMAGE_VARIANT(variant, video, SMEM_IMAGE_TABLE_VIDEO_INDE=
X);
> +       DEBUGFS_IMAGE_OEM(oem, video, SMEM_IMAGE_TABLE_VIDEO_INDEX);

Couldn't these four lines be a function itself that takes the name,
dbg_root, index, etc and create a directory? Looks like a lot of copy
paste right now.

>  }
> =20
>  static void socinfo_debugfs_exit(struct qcom_socinfo *qcom_socinfo)
> --=20
> 2.17.1
>=20
