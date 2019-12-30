Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C29C2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7162820718
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577728568;
	bh=7MiGFHqZ1YA6+XYH5caumqyxTQ0RI4rEMO2Mbg2nz0U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sXXVK5iRWr2GtiuEZqajsVcBsZ1zImHRJZ3y7YZfeGFqOC7uykXLvjWr46EsuYgwM
	 2VgqeReIAov3Ir3IlphHuad9Jg1dYbxJLxyI12B9Y+O9pEHM77mJQxFXFW1EQw516c
	 4WPPi0J7irdsq8R6LoVS885M7lSr8h3srIVR689w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfL3R4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:56:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfL3R4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 12:56:07 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A108320722;
        Mon, 30 Dec 2019 17:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577728566;
        bh=7MiGFHqZ1YA6+XYH5caumqyxTQ0RI4rEMO2Mbg2nz0U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZyNfioOc0BJs6n1P4VurKnXht6n9H55/bqbId7lwwjLYOuj1huX0o87o1aSpIEIOo
         jpE2cI6SHjliW7MRzVXGvIIEXexnXzjSL+3pQbI/CSs9PVEC52nqNggMe2Q/AmKf3k
         SRb+e5peP3wmT/Li0gzTjgxHPAVxXQQo3OwFXkfc=
Received: by mail-qk1-f182.google.com with SMTP id w127so26751459qkb.11;
        Mon, 30 Dec 2019 09:56:06 -0800 (PST)
X-Gm-Message-State: APjAAAXxJxRQk1jKP2qf1wKNRjv0U0Hd+2rOlDJkxCJ/lDfpnyDOcuJ+
        VUb7NeBIhJPyZyOiqiJ6JD5eM/LXOOv+tS5YgQ==
X-Google-Smtp-Source: APXvYqycL5jUu4K0ZnwFoQ0hUtTOiQH/7swu7c5eB4jxMJ/2vkRFQXzEcmU0gS/ZjLfypiZMjlO5nEYX08my7wRarek=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr56359110qkg.152.1577728565786;
 Mon, 30 Dec 2019 09:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20191227111235.GA3370@localhost.localdomain>
In-Reply-To: <20191227111235.GA3370@localhost.localdomain>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 30 Dec 2019 10:55:54 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+rEsFARDejfskLHF_zM8qi8dadLKNhq4a+MxMvfeHiNA@mail.gmail.com>
Message-ID: <CAL_Jsq+rEsFARDejfskLHF_zM8qi8dadLKNhq4a+MxMvfeHiNA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: bd718x7: Yamlify and add BD71850
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2019 at 4:12 AM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:
>
> Convert ROHM bd71837 and bd71847 PMIC binding text docs to yaml. Split
> the binding document to two separate documents (own documents for BD71837
> and BD71847) as they have different amount of regulators. This way we can
> better enforce the node name check for regulators. ROHM is also providing
> BD71850 - which is almost identical to BD71847 - main difference is some
> initial regulator states. The BD71850 can be driven by same driver and it
> has same buck/LDO setup as BD71847 - add it to BD71847 binding document and
> introduce compatible for it.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>
> changes since v1:
> - constrains to short and long presses.
> - reworded commit message to shorten a line exceeding 75 chars
> - added 'additionalProperties: false'
> - removed 'clock-names' from example node
>
>  .../bindings/mfd/rohm,bd71837-pmic.txt        |  90 -------
>  .../bindings/mfd/rohm,bd71837-pmic.yaml       | 236 ++++++++++++++++++
>  .../bindings/mfd/rohm,bd71847-pmic.yaml       | 222 ++++++++++++++++
>  .../regulator/rohm,bd71837-regulator.txt      | 162 ------------
>  .../regulator/rohm,bd71837-regulator.yaml     | 103 ++++++++
>  .../regulator/rohm,bd71847-regulator.yaml     |  97 +++++++
>  6 files changed, 658 insertions(+), 252 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
