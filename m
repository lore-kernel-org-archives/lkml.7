Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F98C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B9621835
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571059446;
	bh=m6XF4o4SsSJ4V485gjFJ25vq9Pu6PVzZfoLQRS3+ep8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ArBg0s3A21udDXkd790ZR7hbwRwJUDBCkVJ5xT1KxCYm5NzySQp/HJmYHzUnOiDY4
	 7UHQ/lre3RnxKwyFmD5KPhYpESTqgfUlSKMtq9kclXVQ1nqlrwdjC2cmldmB2w/Ut7
	 V9clsVLScc6qsDRLa3v8jM0layEmxcFkbWccb4Kk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbfJNNYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfJNNYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:24:04 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0444021D71;
        Mon, 14 Oct 2019 13:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571059444;
        bh=m6XF4o4SsSJ4V485gjFJ25vq9Pu6PVzZfoLQRS3+ep8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YjNLUTo+t3LVgzzI3OkZol6ldaNw/9LGK07uaQQ5g1tHyRtRdE2+G/IjVXLH+lJv4
         vUNIH4zaosIrSmUs4bUkBUHaDbrFdGaE6pYJGZJAdGVoVcnyb2do/QgmaS00As2C+4
         aK3Jx1bBpCP6cs9oGkobyq1PjhRFXDMh7kbe231Q=
Received: by mail-qk1-f174.google.com with SMTP id z67so15811624qkb.12;
        Mon, 14 Oct 2019 06:24:03 -0700 (PDT)
X-Gm-Message-State: APjAAAWldiyB11tonhyKOqVj0XNp1cL1pazwMbi5ojnZWpC12uja7vht
        rzQE9p4SXPh2kZ2Gjq0emW1t/0FsTVxbr5Zrfg==
X-Google-Smtp-Source: APXvYqwFZz5r02Q8zvQ+0YwyjuVSCha6+fsX0DiB2cUKhQvltP4Evo5NpCWKG2okrETOAf6t3D5ierG7w/sOMPF08GE=
X-Received: by 2002:a37:9847:: with SMTP id a68mr30353019qke.223.1571059443085;
 Mon, 14 Oct 2019 06:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <1570025100-5634-1-git-send-email-laurentiu.palcu@nxp.com>
 <1570025100-5634-5-git-send-email-laurentiu.palcu@nxp.com>
 <20191011145042.GA15680@bogus> <20191014080327.GB14065@fsr-ub1664-121>
In-Reply-To: <20191014080327.GB14065@fsr-ub1664-121>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 14 Oct 2019 08:23:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJZHq=jDoK66bTHK+oqSvdrFh9x5a_cNe1hkFdALfs8vw@mail.gmail.com>
Message-ID: <CAL_JsqJZHq=jDoK66bTHK+oqSvdrFh9x5a_cNe1hkFdALfs8vw@mail.gmail.com>
Subject: Re: Re: [PATCH v2 4/5] dt-bindings: display: imx: add bindings for DCSS
To:     Laurentiu Palcu <laurentiu.palcu@nxp.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 3:03 AM Laurentiu Palcu <laurentiu.palcu@nxp.com> w=
rote:
>
> Hi Rob,
>
> On Fri, Oct 11, 2019 at 09:50:42AM -0500, Rob Herring wrote:
> > :u?wc??m5?^?=E3=9E=BE?}4-??z{b???r?+?=D7=80u???=D8=A7????# ?? ??ek ????=
?W?J????^?(???h}??-??z{b???r?Z????+?jW.? \?o=DB=8Awb? ?v+)????l ? b? &??,?&=
??=CE=BE????????????????W???!jx w=CE=A2?=C7=AB?*'??+y?^??^?M:???r=E9=9E=9E=
=D6=AD???u??q?ky?=DB=8Awb? ?v+)????l ? b? &??,?&?? ??? u????=DE=AE???? ?G??=
?h
>
> Ok! Not sure how to address this though... :)

Your mail was base64 which ideally should be avoided on maillists. My
scripting tries to deal with it, but failed obviously. What I said
was:

Reviewed-by: Rob Herring <robh@kernel.org>
