Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E58FC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEB920684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565636318;
	bh=R7sUkUsIyBVyM0xgwC6ssrjHDpSaec6rd52f5BsBnQI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=c0BxnMI1K4ywB/dzgCJ9/n71INPLrCya49lnm0ZsFsS4on3YOhwy+NPHMRCMkkl4k
	 ZrXvZDRvmeJHE7/GkjyO7Noguv0vRdOICiUiL6J+0fDUE6Bd6uBAo230Yewp2+ZiPh
	 boJsIQ3yBCIsd9mEaZ5KDpO9W7Ca975fozw5g2Kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfHLS6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 14:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbfHLS6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:58:36 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 306C22075B;
        Mon, 12 Aug 2019 18:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565636315;
        bh=R7sUkUsIyBVyM0xgwC6ssrjHDpSaec6rd52f5BsBnQI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q/p1uiloLNDD1JaGaTSp7kW8zk6vGVCwMeJHmjWRFZ8xwSTKj2dI3Ll9JxRE/wjhA
         0vRCmaNuDX7okExuF58HoslSn7oeke6LU1HaWU5rDPsFMYcd3uQH/hUXkooSdx8cB1
         vpIN7FKvtlyV9vVkX4BVNAmJyb9jELe++tKI/mho=
Received: by mail-qt1-f181.google.com with SMTP id d17so24954019qtj.8;
        Mon, 12 Aug 2019 11:58:35 -0700 (PDT)
X-Gm-Message-State: APjAAAVGHbemEwBJFHf1Jtvv+l8cvSLR9PHLg2SzzEcbJ7TcphuXfu2g
        +6DzzxYwecPD5PzEFYtLJmnhSlki1jOQNc15Tg==
X-Google-Smtp-Source: APXvYqzFjlTyS2m8jvSL/rEOx3inN5YXegwV3lD2MVMO9vmnvZIOtTu5uyTMAAy7H8+QyiC/chnN1YS23chwygY3KUU=
X-Received: by 2002:ac8:44c4:: with SMTP id b4mr19765999qto.224.1565636314436;
 Mon, 12 Aug 2019 11:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190809112853.15846-1-stefan-gabriel.mirea@nxp.com> <20190809112853.15846-2-stefan-gabriel.mirea@nxp.com>
In-Reply-To: <20190809112853.15846-2-stefan-gabriel.mirea@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 12 Aug 2019 12:58:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJkTzcUnDCoWH9DP9LpwpdBh3wWHzPVfg=ieTTZet92pw@mail.gmail.com>
Message-ID: <CAL_JsqJkTzcUnDCoWH9DP9LpwpdBh3wWHzPVfg=ieTTZet92pw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: arm: fsl: Add the S32V234-EVB board
To:     Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Eddy Petrisor <eddy.petrisor@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 5:29 AM Stefan-gabriel Mirea
<stefan-gabriel.mirea@nxp.com> wrote:
>
> From: Eddy Petri=C8=99or <eddy.petrisor@nxp.com>
>
> Add entry for the NXP S32V234 Customer Evaluation Board to the board/SoC
> bindings.
>
> Signed-off-by: Eddy Petri=C8=99or <eddy.petrisor@nxp.com>
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
