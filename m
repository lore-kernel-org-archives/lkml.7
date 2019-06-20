Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E0BC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7E02082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561065724;
	bh=PuhWklVRpaKRPUdE/osVEB200NX11siaEZ9LkAA1azU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0LTo6cTj+Y+rn0q6XfDFWEf4OhrNNEeP3a+tQY8M0viT+GZt0wWgy8/jq0cwz0xV0
	 UdN8s/ceExM8AwBw1/3S8l/BVocXcF+7SsgTnZNvBT+uhLAu3ASwjbDxqV2iemKRLF
	 R2/XiSUWC5u41NSPGdHibr8QwAsn7tOYCqPvuIJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfFTVWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfFTVWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:22:01 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E09122070B;
        Thu, 20 Jun 2019 21:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561065721;
        bh=PuhWklVRpaKRPUdE/osVEB200NX11siaEZ9LkAA1azU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wMT/eGGX5rgi0UumcB9ySgJrQvnHSpdFkShEGs//+AtXtkl0Hx0HCBHM9CNdQiilm
         5HOpAxBrRkCVv8/lp5t3aB/qHwrfsVkq+X+v/Tx5i3bOuV2rLmyPm+OfXiqh+999xt
         Xt2kXsb0/2mmzNRBLFgp58Y0XgAW4RDO0/6tzuz4=
Received: by mail-qt1-f178.google.com with SMTP id h21so4689369qtn.13;
        Thu, 20 Jun 2019 14:22:00 -0700 (PDT)
X-Gm-Message-State: APjAAAXStTYgAC9NDurR9ZpHguMPOTteioIhxY9InoCgipA60szdlUbs
        DpN96ITYojJRTWXsZHP0h0rC7FGiGMAsOiChCA==
X-Google-Smtp-Source: APXvYqy7ldYy4oFwY2FLe2za3Zythuiw6FYWYsjwzoz/t/Lj5bmUGGfLv9hFcgJ3gb3PjNVWliSHbjb7UzY8UtmgkE4=
X-Received: by 2002:a0c:b627:: with SMTP id f39mr42469091qve.72.1561065720166;
 Thu, 20 Jun 2019 14:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190620195011.30942-1-tduszyns@gmail.com> <20190620195011.30942-2-tduszyns@gmail.com>
In-Reply-To: <20190620195011.30942-2-tduszyns@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 20 Jun 2019 15:21:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLmZPTYqSkmSo-KuqUr7FY1BqE3XX7+PhcA_0phS4X3jQ@mail.gmail.com>
Message-ID: <CAL_JsqLmZPTYqSkmSo-KuqUr7FY1BqE3XX7+PhcA_0phS4X3jQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: chemical: sps30: convert bindings
 to yaml
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 1:52 PM Tomasz Duszynski <tduszyns@gmail.com> wrote:
>
> Convert existing device tree bindings to yaml.
>
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  .../bindings/iio/chemical/sensirion,sps30.txt | 12 ------
>  .../iio/chemical/sensirion,sps30.yaml         | 39 +++++++++++++++++++
>  2 files changed, 39 insertions(+), 12 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
