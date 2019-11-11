Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D27DC17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E2820656
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Xmhd3mlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfKKInx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:43:53 -0500
Received: from mout.web.de ([212.227.15.4]:43783 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfKKInv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573461759;
        bh=0J3c8iXj6IK/Il74rucQQ6zV7qAU3Woh4DCZdChB76U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Xmhd3mlpf/GxVFUQ1nCaQImC+wY/SH8thCkkD7Qg/ov4s6mrFGikofNJxbg/tauoH
         IkmdT9s0DyingbfbqrANeGQyxXtxcgPAoIMdPYZ/+06tqLOS0jZdhPB8fhJMgA8y+3
         x2+D84QJdi5MncxlLQSbrBLxcyAoFbh2pmzfTkLc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [10.9.8.2] ([80.130.117.228]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lh6PP-1i9bp33LAF-00oYPt; Mon, 11
 Nov 2019 09:42:39 +0100
Subject: Re: [PATCH 3/3] arm64: dts: rk3399: Add init voltage for vdd_log
To:     Kever Yang <kever.yang@rock-chips.com>, heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Akash Gajjar <akash@openedev.com>,
        Alexis Ballier <aballier@gentoo.org>,
        =?UTF-8?Q?Andrius_=c5=a0tikonas?= <andrius@stikonas.eu>,
        Andy Yan <andyshrk@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Xie <nick@khadas.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Pragnesh Patel <Pragnesh_Patel@mentor.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20191111005158.25070-1-kever.yang@rock-chips.com>
 <20191111005158.25070-3-kever.yang@rock-chips.com>
From:   Soeren Moch <smoch@web.de>
Message-ID: <ef8830f3-10d1-7b71-0e18-232f2eaeef2d@web.de>
Date:   Mon, 11 Nov 2019 09:42:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111005158.25070-3-kever.yang@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:uKVi7Jd/flif9wD0aTOO4Rct22jlxJlLpyYMD2lCtDTB92+H+qM
 iTK2J4wnku5T8oDPML/7gsACuYmZqME02y/zekk4hAZTqggqNXRCnJJvP+nd8z+FSW/GuHz
 i5WDx+h2qbV5shdLRUCDQV5yZEBO4R0xzOq9I3NNuU5gw7+Fe4CbHHI6ijhsYomP0/IOgpT
 k6F9wx6Yufdo3CyjlWULQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zc0nUcVttNU=:2UP8emA8JD8vTiy+255QQU
 yY9SBU42UfednHSTTZXYUtZ94Af+MDx+VnfHxBaHO5lobUpY4MOIkKqhkqy4BW+xKKOx/BmIK
 q89Oj8l+KCs4tRg/C9y07M7Gtd0YiYdEVeH0UagIYBfmTkh8bTidttX69wjU9jnGKNXa0e4Fs
 ySLqdO9QYSX3zEEfR1N2MMGbzKAUdW0BtpA5+AMAXIUTfOr84oTPYyFfDpexqh5okPGVah7ls
 zjlR3lD5S8Jbg6keKcw7H+tC0lYDkbTgbqGcWwbhY62ELZ9M7n5Wqwq1Lf5kGXhh8vDaGjf/k
 ApwBvQ+/HFpjqg8CuXvPHGe8w3WzT5vyKa3OWJPiRmeosNTWlLF/3b0b1C8M6vIcppUCp7bB0
 pZb9drBvDYumrurtYZcWblRoTzRXNiHly1mmGLwXSRFwIbGdkIQiWSPLUVX76sdMszU01EicS
 40eDdlgfTZgUp6iKAgQckD1LXO/fhmvV3M+aOl6dXmFrLgXNDoWKLPJLT6P4JlhQ8rQhWVoOL
 tYR9SE92+vgJmHztH8MsNAJQTdE4YAA4vskdLxD93nS5tfHk69y3KRMbRxtyt8uvr8sZZ+Frk
 +VFwTRTJ2P9LnabUiyeYkPc3C1FJFUFthO8ExDM8oqviyZLbOd9XLWZMTDxPjvl9j4cyPV9rx
 RgzyA13Ji8t+Ffid+ljUSOOQj9s99OPehLmEGqlpbqcqUwLPLYUQy/2pdP7wOh66wwj1O/Hle
 4rPk49rQaeDD90InhCegZvyGQBSK7ShSu07PbNmKLmKejHfJPj7L2akBrS+wb1gw4pvKOZ//E
 yWxzA0MZ67swu52Mk3xfS69hBkEv1CbTwXECcZCLNYQPcwMlJ6Lcaq4noDD76QmKrHvAC5E0d
 UVVSy0TXJ4YnpSyv6ahdY26/KLB01LNUd8Cu86cmWFR2caa0/qtWMVWUtkDozzYd78R+oHESV
 7erhF0XnkdBw13dxBIdx0Vy0B8wa9iOtUO3qlkY0nPoEst0AZJNZKtDBBf/6BV+uB6fTnvACP
 7rxmbg36qN0IBjRVh05SyOxraZQjYeU6auJMp99BGst3fTImRRyZMmWDa57oZvEQbno322Inx
 UjdlpNBtHiiPk/hFHqwg1qVHdW7K1FxJcq51cjhQRy5rYVgp6OGWpztnLvIG9GDfVYsjckehp
 oFHIuHMe2lpbiRan7xHyevJ0JE9t/Dz6bwWrXtkrUG10YIsriO1ADrJBB1g/fsyJheqIMU9Zf
 OLb0lQj0xVMp84l5aDqSZ8Tq2hc9N8vQfjeua2A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.19 01:51, Kever Yang wrote:
> Since there is no devfreq used for vdd_log, so the vdd_log(pwm regulator=
)
> will be 'enable' with the dts node at a default PWM state with high or l=
ow
> output. Both too high or too low for vdd_log is not good for the board,
> add init voltage for driver to make the regulator get into a know output=
.
>
> Note that this will be used by U-Boot for init voltage output, and this
> is very important for it may get system hang somewhere during system
> boot up with regulator enable and without this init value.
I think it's a good idea to include this setting in the main dts for the
boards (not in u-boot specific additions as is done now). But there is
(for some reason?) no documented binding for regulator-init-microvolt in
linux.

Regards,
Soeren
>
> CC: Elaine Zhang <zhangqing@rock-chips.com>
> CC: Peter Robinson <pbrobinson@gmail.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>
>  arch/arm64/boot/dts/rockchip/rk3399-evb.dts          | 1 +
>  arch/arm64/boot/dts/rockchip/rk3399-firefly.dts      | 1 +
>  arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts   | 1 +
>  arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi | 1 +
>  arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts    | 1 +
>  arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts     | 1 +
>  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts       | 1 +
>  arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts    | 1 +
>  arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi    | 1 +
>  9 files changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/bo=
ot/dts/rockchip/rk3399-evb.dts
> index 77008dca45bc..fa241aeb11b0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
> @@ -65,6 +65,7 @@
>  		regulator-name =3D "vdd_center";
>  		regulator-min-microvolt =3D <800000>;
>  		regulator-max-microvolt =3D <1400000>;
> +		regulator-init-microvolt =3D <950000>;
>  		regulator-always-on;
>  		regulator-boot-on;
>  		status =3D "okay";
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm6=
4/boot/dts/rockchip/rk3399-firefly.dts
> index 92de83dd4dbc..4e45269fcdff 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
> @@ -208,6 +208,7 @@
>  		regulator-boot-on;
>  		regulator-min-microvolt =3D <430000>;
>  		regulator-max-microvolt =3D <1400000>;
> +		regulator-init-microvolt =3D <950000>;
>  		vin-supply =3D <&vcc_sys>;
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts b/arch/a=
rm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> index c133e8d64b2a..692f3154edc3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> @@ -100,6 +100,7 @@
>  		regulator-name =3D "vdd_log";
>  		regulator-min-microvolt =3D <800000>;
>  		regulator-max-microvolt =3D <1400000>;
> +		regulator-init-microvolt =3D <950000>;
>  		regulator-always-on;
>  		regulator-boot-on;
>  	};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch=
/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> index 4944d78a0a1c..c2ac80d99301 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> @@ -79,6 +79,7 @@
>  		regulator-boot-on;
>  		regulator-min-microvolt =3D <800000>;
>  		regulator-max-microvolt =3D <1400000>;
> +		regulator-init-microvolt =3D <950000>;
>  		vin-supply =3D <&vsys_3v3>;
>  	};
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts b/arch/ar=
m64/boot/dts/rockchip/rk3399-leez-p710.dts
> index 73be38a53796..c32abcc4ddc1 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
> @@ -101,6 +101,7 @@
>  		regulator-boot-on;
>  		regulator-min-microvolt =3D <800000>;
>  		regulator-max-microvolt =3D <1400000>;
> +		regulator-init-microvolt =3D <950000>;
>  		vin-supply =3D <&vcc5v0_sys>;
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts b/arch/arm=
64/boot/dts/rockchip/rk3399-orangepi.dts
> index 0541dfce924d..9d674c51f025 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
> @@ -164,6 +164,7 @@
>  		regulator-boot-on;
>  		regulator-min-microvolt =3D <800000>;
>  		regulator-max-microvolt =3D <1400000>;
> +		regulator-init-microvolt =3D <950000>;
>  		vin-supply =3D <&vcc_sys>;
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64=
/boot/dts/rockchip/rk3399-roc-pc.dts
> index 19f7732d728c..7d856ce1d156 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> @@ -129,6 +129,7 @@
>  		regulator-boot-on;
>  		regulator-min-microvolt =3D <800000>;
>  		regulator-max-microvolt =3D <1400000>;
> +		regulator-init-microvolt =3D <950000>;
>  		vin-supply =3D <&vcc3v3_sys>;
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/ar=
m64/boot/dts/rockchip/rk3399-rockpro64.dts
> index e544deb61d28..8fbccbc8bf47 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> @@ -174,6 +174,7 @@
>  		regulator-boot-on;
>  		regulator-min-microvolt =3D <800000>;
>  		regulator-max-microvolt =3D <1700000>;
> +		regulator-init-microvolt =3D <950000>;
>  		vin-supply =3D <&vcc5v0_sys>;
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi b/arch/ar=
m64/boot/dts/rockchip/rk3399-sapphire.dtsi
> index 1bc1579674e5..f8e2cb8c0624 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
> @@ -133,6 +133,7 @@
>  		regulator-boot-on;
>  		regulator-min-microvolt =3D <800000>;
>  		regulator-max-microvolt =3D <1400000>;
> +		regulator-init-microvolt =3D <950000>;
>  		vin-supply =3D <&vcc_sys>;
>  	};
>  };

