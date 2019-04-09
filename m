Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E38C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7418820883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfDIV1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:27:52 -0400
Received: from anholt.net ([50.246.234.109]:39500 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfDIV1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:27:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 0331710A32F0;
        Tue,  9 Apr 2019 14:27:51 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 77TDicqk8Zew; Tue,  9 Apr 2019 14:27:49 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id ACC7310A32EE;
        Tue,  9 Apr 2019 14:27:49 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 4C8C82FE36FA; Tue,  9 Apr 2019 14:27:49 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        "Marty E . Plummer" <hanetzer@startmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH v3 3/3] drm/panfrost: Add initial panfrost driver
In-Reply-To: <87v9zmdg66.fsf@anholt.net>
References: <20190409205427.6943-1-robh@kernel.org> <20190409205427.6943-4-robh@kernel.org> <87v9zmdg66.fsf@anholt.net>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/26.1 (x86_64-pc-linux-gnu)
Date:   Tue, 09 Apr 2019 14:27:49 -0700
Message-ID: <87sguqdg2y.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Eric Anholt <eric@anholt.net> writes:

> [ Unknown signature status ]
> Rob Herring <robh@kernel.org> writes:
>
>> This adds the initial driver for panfrost which supports Arm Mali
>> Midgard and Bifrost family of GPUs. Currently, only the T860 and
>> T760 Midgard GPUs have been tested.
>
>> +static int panfrost_ioctl_get_bo_offset(struct drm_device *dev, void *data,
>> +			    struct drm_file *file_priv)
>> +{
>> +	struct drm_panfrost_get_bo_offset *args = data;
>> +	struct drm_gem_object *gem_obj;
>> +	struct panfrost_gem_object *bo;
>> +
>
> Missing check for pad == 0.  With that fixed,
>
> Reviewed-by: Eric Anholt <eric@anholt.net>

I suppose you could also drop both flags and pad from uapi, since both
of them must be 0 filled and you could just add a new flags at the end
of the create struct if you ever need one.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlytDlUACgkQtdYpNtH8
nujTvQ/8DLl9gw2KT5rPuNbZlc1c0j7l4nxEJVuTaGb8y+CDcmeAthE+6yavpYOz
sOYfejrD3xh/I3dW0hagyx3N2roqqT6U4n6AAQoG3g79pnlOY/1KQsJoyOU1InEl
KNxXe51S4oeCL09w/Kd4ywW8sxbxofLZAlkzySQW+ClkAv0fPApu/fTrukjlHXER
lxX0he8uJPmaetHkHoaT5JUNoLth0vQ4iwOWLu6L37YzeWtGU2AmJMMDmPdPuks5
ot6Yt0kwCXGFtPDQBarR1TTZvA2vBOuwEgDVnCuea2e406pmkcURJOlWdCfCIN93
LKURY77dQAuXTsL8XwBeBb/ZPcB2fe3w2Htwygb++R4SFAKdWSGCZ4xtZSHBr+O6
Pr/hhUeFBZSF7/LK9d6U1vvAAf85VE4GQi2a0rNEKRkYuslEk36cs138DCu2Sx4k
oBd7ONwV6Lt9l2J35vcIAjIY/H3/Yzz0ZGHMI4CYwNXwZGJcQd0GInwltNgEWKp3
ROmVgQzXy4CChxfykBj9laABo8GDPXfc5QKBsmsYsaaSwV24w6OY0ln4Mx8RP3Zl
mUhHxIA0Bmr7yHly+V5Ac+Q0N2DPck5cOqI/XhYTS7TnQkLlmpCYsjLcDjMK0gGI
BWieLpmbRFYcCwLFPEWyBXGFXIE1eIZWe2fJMzb6Lep5D2hFT1U=
=16Ej
-----END PGP SIGNATURE-----
--=-=-=--
