Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2F1C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C90220644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561470825;
	bh=IBl6wjwQEg5HowO1K0RyGQhG2zIw7iue4CmMC1swZNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dNc9JbVHFJDAltb6Rnj52vJ1zLEQDGdWOR4NI4P/+4GB9sv4i2qDNP9ZluRkHOIAK
	 u5MfBsf2V/kceIC1tP1PeWjbbxkx+bTH3y2uPprEmF1ywsnKCJ3cJAGsP+njKQdpI7
	 dR9vPKzuZwLo2etlR5G7tpX+Eo2mMv9XLlYILk2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfFYNxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:53:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfFYNxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JGpGM39AHHAVQEfNPYm+uyOwKNb/vK0fhvO/kdVvXZo=; b=b0AC27mdBCzakcaO3d8RD1wci
        oNCj45nruXMgZOOUjDYEkkMNlr0v/rZNn1vZJ7sSZEGiE+uXOlIqXaMviy8S8XRWF3g8HXhC4DF8j
        D8yxwJGuRC7WkmpBjJEjsfd7VVSU/x5P3nQirHUs9CeaxISZ6AvV+sWhTtCQXxZqlwFR7UCu/SDU6
        ic6qrjRsbTDEqTLF7Nnb20Kdh4XePP8la/1ZRIgnhlfvYX4xPwp9M1g9p72J/CgYuKesE9bScn0Y5
        jhEtOWKg8L5oePLgozTqgLCc/viSOu1ai/ZHw9JJAzxDbeYzD1cM3q8j0jNDNk4EG4QpWPQvIPnkO
        2JfSAIbgQ==;
Received: from 177.205.71.220.dynamic.adsl.gvt.net.br ([177.205.71.220] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfltE-0002pZ-0a; Tue, 25 Jun 2019 13:53:41 +0000
Date:   Tue, 25 Jun 2019 10:53:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH v1 04/22] docs: thermal: convert to ReST
Message-ID: <20190625105334.19ae5d12@coco.lan>
In-Reply-To: <1561470011.19713.1.camel@intel.com>
References: <cover.1560891322.git.mchehab+samsung@kernel.org>
        <23fafb70bfc9bd8b7f306f2502617d8f8794eae5.1560891322.git.mchehab+samsung@kernel.org>
        <1561470011.19713.1.camel@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 25 Jun 2019 21:40:11 +0800
Zhang Rui <rui.zhang@intel.com> escreveu:

> On =E4=BA=8C, 2019-06-18 at 18:05 -0300, Mauro Carvalho Chehab wrote:
> > Rename the thermal documentation files to ReST, add an
> > index for them and adjust in order to produce a nice html
> > output via the Sphinx build system.
> >=20
> > At its new index.rst, let's add a :orphan: while this is not linked
> > to
> > the main index.rst file, in order to avoid build warnings.
> >=20
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org> =20
>=20
> Acked-by: Zhang Rui <rui.zhang@intel.com>
>=20
> should I apply this patch or you have a separate tree for all these
> changes?

Feel free to apply it directly to your tree. The patches on this
series are pretty much independent.

>=20
> thanks,
> rui
> > ---
> > =C2=A0...pu-cooling-api.txt =3D> cpu-cooling-api.rst} |=C2=A0=C2=A039 +-
> > =C2=A0.../{exynos_thermal =3D> exynos_thermal.rst}=C2=A0=C2=A0=C2=A0=C2=
=A0|=C2=A0=C2=A047 +-
> > =C2=A0...emulation =3D> exynos_thermal_emulation.rst} |=C2=A0=C2=A066 +=
--
> > =C2=A0Documentation/thermal/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A018 +
> > =C2=A0...el_powerclamp.txt =3D> intel_powerclamp.rst} | 177 +++----
> > =C2=A0.../{nouveau_thermal =3D> nouveau_thermal.rst}=C2=A0=C2=A0|=C2=A0=
=C2=A054 +-
> > =C2=A0...ower_allocator.txt =3D> power_allocator.rst} | 140 ++---
> > =C2=A0.../thermal/{sysfs-api.txt =3D> sysfs-api.rst}=C2=A0=C2=A0| 490 +=
+++++++++++--
> > ----
> > =C2=A0...hermal =3D> x86_pkg_temperature_thermal.rst} |=C2=A0=C2=A028 +-
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A0=C2=A02 +-
> > =C2=A0include/linux/thermal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A04 +-
> > =C2=A011 files changed, 665 insertions(+), 400 deletions(-)
> > =C2=A0rename Documentation/thermal/{cpu-cooling-api.txt =3D> cpu-coolin=
g-
> > api.rst} (82%)
> > =C2=A0rename Documentation/thermal/{exynos_thermal =3D> exynos_thermal.=
rst}
> > (67%)
> > =C2=A0rename Documentation/thermal/{exynos_thermal_emulation =3D>
> > exynos_thermal_emulation.rst} (36%)
> > =C2=A0create mode 100644 Documentation/thermal/index.rst
> > =C2=A0rename Documentation/thermal/{intel_powerclamp.txt =3D>
> > intel_powerclamp.rst} (76%)
> > =C2=A0rename Documentation/thermal/{nouveau_thermal =3D>
> > nouveau_thermal.rst} (64%)
> > =C2=A0rename Documentation/thermal/{power_allocator.txt =3D>
> > power_allocator.rst} (74%)
> > =C2=A0rename Documentation/thermal/{sysfs-api.txt =3D> sysfs-api.rst} (=
66%)
> > =C2=A0rename Documentation/thermal/{x86_pkg_temperature_thermal =3D>
> > x86_pkg_temperature_thermal.rst} (80%)
> >=20
> > diff --git a/Documentation/thermal/cpu-cooling-api.txt
> > b/Documentation/thermal/cpu-cooling-api.rst
> > similarity index 82%
> > rename from Documentation/thermal/cpu-cooling-api.txt
> > rename to Documentation/thermal/cpu-cooling-api.rst
> > index 7df567eaea1a..645d914c45a6 100644
> > --- a/Documentation/thermal/cpu-cooling-api.txt
> > +++ b/Documentation/thermal/cpu-cooling-api.rst
> > @@ -1,5 +1,6 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0CPU cooling APIs How To
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > =C2=A0Written by Amit Daniel Kachhap <amit.kachhap@linaro.org>
> > =C2=A0
> > @@ -8,40 +9,54 @@ Updated: 6 Jan 2015
> > =C2=A0Copyright (c)=C2=A0=C2=A02012 Samsung Electronics Co., Ltd(http:/=
/www.samsung.
> > com)
> > =C2=A0
> > =C2=A00. Introduction
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > =C2=A0The generic cpu cooling(freq clipping) provides
> > registration/unregistration APIs
> > =C2=A0to the caller. The binding of the cooling devices to the trip poi=
nt
> > is left for
> > =C2=A0the user. The registration APIs returns the cooling device pointe=
r.
> > =C2=A0
> > =C2=A01. cpu cooling APIs
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > =C2=A01.1 cpufreq registration/unregistration APIs
> > -1.1.1 struct thermal_cooling_device *cpufreq_cooling_register(
> > -	struct cpumask *clip_cpus)
> > +--------------------------------------------
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0::
> > +
> > +	struct thermal_cooling_device
> > +	*cpufreq_cooling_register(struct cpumask *clip_cpus)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This interface function registers the cpu=
freq cooling device
> > with the name
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"thermal-cpufreq-%x". This api can suppor=
t multiple instances of
> > cpufreq
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cooling devices.
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0clip_cpus: cpumask of cpus where the frequency const=
raints will
> > happen.
> > +=C2=A0=C2=A0=C2=A0clip_cpus:
> > +	cpumask of cpus where the frequency constraints will happen.
> > =C2=A0
> > -1.1.2 struct thermal_cooling_device *of_cpufreq_cooling_register(
> > -					struct cpufreq_policy
> > *policy)
> > +=C2=A0=C2=A0=C2=A0=C2=A0::
> > +
> > +	struct thermal_cooling_device
> > +	*of_cpufreq_cooling_register(struct cpufreq_policy *policy)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This interface function registers the cpu=
freq cooling device
> > with
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0the name "thermal-cpufreq-%x" linking it =
with a device tree
> > node, in
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0order to bind it via the thermal DT code.=
 This api can support
> > multiple
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0instances of cpufreq cooling devices.
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0policy: CPUFreq policy.
> > +=C2=A0=C2=A0=C2=A0=C2=A0policy:
> > +	CPUFreq policy.
> > =C2=A0
> > -1.1.3 void cpufreq_cooling_unregister(struct thermal_cooling_device
> > *cdev)
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0::
> > +
> > +	void cpufreq_cooling_unregister(struct
> > thermal_cooling_device *cdev)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This interface function unregisters the "=
thermal-cpufreq-%x"
> > cooling device.
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cdev: Cooling device pointer which has to=
 be unregistered.
> > =C2=A0
> > =C2=A02. Power models
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > =C2=A0The power API registration functions provide a simple power model
> > for
> > =C2=A0CPUs.=C2=A0=C2=A0The current power is calculated as dynamic power=
 (static
> > power isn't
> > @@ -65,9 +80,9 @@ For a given processor implementation the primary
> > factors are:
> > =C2=A0=C2=A0=C2=A0variation.=C2=A0=C2=A0In pathological cases this vari=
ation can be
> > significant,
> > =C2=A0=C2=A0=C2=A0but typically it is of a much lesser impact than the =
factors
> > above.
> > =C2=A0
> > -A high level dynamic power consumption model may then be represented
> > as:
> > +A high level dynamic power consumption model may then be represented
> > as::
> > =C2=A0
> > -Pdyn =3D f(run) * Voltage^2 * Frequency * Utilisation
> > +	Pdyn =3D f(run) * Voltage^2 * Frequency * Utilisation
> > =C2=A0
> > =C2=A0f(run) here represents the described execution behaviour and its
> > =C2=A0result has a units of Watts/Hz/Volt^2 (this often expressed in
> > @@ -80,9 +95,9 @@ factors.=C2=A0=C2=A0Therefore, in initial implementat=
ion that
> > contribution is
> > =C2=A0represented as a constant coefficient.=C2=A0=C2=A0This is a simpl=
ification
> > =C2=A0consistent with the relative contribution to overall power
> > variation.
> > =C2=A0
> > -In this simplified representation our model becomes:
> > +In this simplified representation our model becomes::
> > =C2=A0
> > -Pdyn =3D Capacitance * Voltage^2 * Frequency * Utilisation
> > +	Pdyn =3D Capacitance * Voltage^2 * Frequency * Utilisation
> > =C2=A0
> > =C2=A0Where `capacitance` is a constant that represents an indicative
> > =C2=A0running time dynamic power coefficient in fundamental units of
> > diff --git a/Documentation/thermal/exynos_thermal
> > b/Documentation/thermal/exynos_thermal.rst
> > similarity index 67%
> > rename from Documentation/thermal/exynos_thermal
> > rename to Documentation/thermal/exynos_thermal.rst
> > index 9010c4416967..5bd556566c70 100644
> > --- a/Documentation/thermal/exynos_thermal
> > +++ b/Documentation/thermal/exynos_thermal.rst
> > @@ -1,8 +1,11 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > =C2=A0Kernel driver exynos_tmu
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > =C2=A0
> > =C2=A0Supported chips:
> > +
> > =C2=A0* ARM SAMSUNG EXYNOS4, EXYNOS5 series of SoC
> > +
> > =C2=A0=C2=A0=C2=A0Datasheet: Not publicly available
> > =C2=A0
> > =C2=A0Authors: Donggeun Kim <dg77.kim@samsung.com>
> > @@ -19,32 +22,39 @@ Temperature can be taken from the temperature
> > code.
> > =C2=A0There are three equations converting from temperature to temperat=
ure
> > code.
> > =C2=A0
> > =C2=A0The three equations are:
> > -=C2=A0=C2=A01. Two point trimming
> > +=C2=A0=C2=A01. Two point trimming::
> > +
> > =C2=A0	Tc =3D (T - 25) * (TI2 - TI1) / (85 - 25) + TI1
> > =C2=A0
> > -=C2=A0=C2=A02. One point trimming
> > +=C2=A0=C2=A02. One point trimming::
> > +
> > =C2=A0	Tc =3D T + TI1 - 25
> > =C2=A0
> > -=C2=A0=C2=A03. No trimming
> > +=C2=A0=C2=A03. No trimming::
> > +
> > =C2=A0	Tc =3D T + 50
> > =C2=A0
> > -=C2=A0=C2=A0Tc: Temperature code, T: Temperature,
> > -=C2=A0=C2=A0TI1: Trimming info for 25 degree Celsius (stored at TRIMIN=
FO
> > register)
> > +=C2=A0=C2=A0Tc:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Temperature code, T: Tempera=
ture,
> > +=C2=A0=C2=A0TI1:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Trimming info for 25 degree =
Celsius (stored at TRIMINFO
> > register)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Temperature code measur=
ed at 25 degree Celsius which is
> > unchanged
> > -=C2=A0=C2=A0TI2: Trimming info for 85 degree Celsius (stored at TRIMIN=
FO
> > register)
> > +=C2=A0=C2=A0TI2:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Trimming info for 85 degree =
Celsius (stored at TRIMINFO
> > register)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Temperature code measur=
ed at 85 degree Celsius which is
> > unchanged
> > =C2=A0
> > =C2=A0TMU(Thermal Management Unit) in EXYNOS4/5 generates interrupt
> > =C2=A0when temperature exceeds pre-defined levels.
> > =C2=A0The maximum number of configurable threshold is five.
> > -The threshold levels are defined as follows:
> > +The threshold levels are defined as follows::
> > +
> > =C2=A0=C2=A0=C2=A0Level_0: current temperature > trigger_level_0 + thre=
shold
> > =C2=A0=C2=A0=C2=A0Level_1: current temperature > trigger_level_1 + thre=
shold
> > =C2=A0=C2=A0=C2=A0Level_2: current temperature > trigger_level_2 + thre=
shold
> > =C2=A0=C2=A0=C2=A0Level_3: current temperature > trigger_level_3 + thre=
shold
> > =C2=A0
> > -=C2=A0=C2=A0The threshold and each trigger_level are set
> > -=C2=A0=C2=A0through the corresponding registers.
> > +The threshold and each trigger_level are set
> > +through the corresponding registers.
> > =C2=A0
> > =C2=A0When an interrupt occurs, this driver notify kernel thermal
> > framework
> > =C2=A0with the function exynos_report_trigger.
> > @@ -54,24 +64,27 @@ it can be used to synchronize the cooling action.
> > =C2=A0TMU driver description:
> > =C2=A0-----------------------
> > =C2=A0
> > -The exynos thermal driver is structured as,
> > +The exynos thermal driver is structured as::
> > =C2=A0
> > =C2=A0					Kernel Core thermal
> > framework
> > =C2=A0				(thermal_core.c, step_wise.c,
> > cpu_cooling.c)
> > =C2=A0								^
> > =C2=A0								|
> > =C2=A0								|
> > -TMU configuration data -------> TMU Driver=C2=A0=C2=A0<------> Exynos =
Core
> > thermal wrapper
> > -(exynos_tmu_data.c)	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(exynos_tmu.c)=
	=C2=A0=C2=A0=C2=A0(exynos_th
> > ermal_common.c)
> > -(exynos_tmu_data.h)	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(exynos_tmu.h)=
	=C2=A0=C2=A0=C2=A0(exynos_th
> > ermal_common.h)
> > +=C2=A0=C2=A0TMU configuration data -----> TMU Driver=C2=A0=C2=A0<---->=
 Exynos Core
> > thermal wrapper
> > +=C2=A0=C2=A0(exynos_tmu_data.c)	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(e=
xynos_tmu.c)	=C2=A0=C2=A0=C2=A0(exynos_
> > thermal_common.c)
> > +=C2=A0=C2=A0(exynos_tmu_data.h)	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(e=
xynos_tmu.h)	=C2=A0=C2=A0=C2=A0(exynos_
> > thermal_common.h)
> > =C2=A0
> > -a) TMU configuration data: This consist of TMU register
> > offsets/bitfields
> > +a) TMU configuration data:
> > +		This consist of TMU register offsets/bitfields
> > =C2=A0		described through structure exynos_tmu_registers.
> > Also several
> > =C2=A0		other platform data (struct
> > exynos_tmu_platform_data) members
> > =C2=A0		are used to configure the TMU.
> > -b) TMU driver: This component initialises the TMU controller and
> > sets different
> > +b) TMU driver:
> > +		This component initialises the TMU controller and
> > sets different
> > =C2=A0		thresholds. It invokes core thermal implementation
> > with the call
> > =C2=A0		exynos_report_trigger.
> > -c) Exynos Core thermal wrapper: This provides 3 wrapper function to
> > use the
> > +c) Exynos Core thermal wrapper:
> > +		This provides 3 wrapper function to use the
> > =C2=A0		Kernel core thermal framework. They are
> > exynos_unregister_thermal,
> > =C2=A0		exynos_register_thermal and exynos_report_trigger.
> > diff --git a/Documentation/thermal/exynos_thermal_emulation
> > b/Documentation/thermal/exynos_thermal_emulation.rst
> > similarity index 36%
> > rename from Documentation/thermal/exynos_thermal_emulation
> > rename to Documentation/thermal/exynos_thermal_emulation.rst
> > index b15efec6ca28..c21d10838bc5 100644
> > --- a/Documentation/thermal/exynos_thermal_emulation
> > +++ b/Documentation/thermal/exynos_thermal_emulation.rst
> > @@ -1,5 +1,6 @@
> > -EXYNOS EMULATION MODE
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Exynos Emulation Mode
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > =C2=A0Copyright (C) 2012 Samsung Electronics
> > =C2=A0
> > @@ -8,46 +9,53 @@ Written by Jonghwa Lee <jonghwa3.lee@samsung.com>
> > =C2=A0Description
> > =C2=A0-----------
> > =C2=A0
> > -Exynos 4x12 (4212, 4412) and 5 series provide emulation mode for
> > thermal management unit.
> > -Thermal emulation mode supports software debug for TMU's operation.
> > User can set temperature
> > -manually with software code and TMU will read current temperature
> > from user value not from
> > -sensor's value.
> > +Exynos 4x12 (4212, 4412) and 5 series provide emulation mode for
> > thermal
> > +management unit. Thermal emulation mode supports software debug for
> > +TMU's operation. User can set temperature manually with software
> > code
> > +and TMU will read current temperature from user value not from
> > sensor's
> > +value.
> > =C2=A0
> > -Enabling CONFIG_THERMAL_EMULATION option will make this support
> > available.
> > -When it's enabled, sysfs node will be created as
> > +Enabling CONFIG_THERMAL_EMULATION option will make this support
> > +available. When it's enabled, sysfs node will be created as
> > =C2=A0/sys/devices/virtual/thermal/thermal_zone'zone id'/emul_temp.
> > =C2=A0
> > -The sysfs node, 'emul_node', will contain value 0 for the initial
> > state. When you input any
> > -temperature you want to update to sysfs node, it automatically
> > enable emulation mode and
> > -current temperature will be changed into it.
> > -(Exynos also supports user changeable delay time which would be used
> > to delay of
> > - changing temperature. However, this node only uses same delay of
> > real sensing time, 938us.)
> > +The sysfs node, 'emul_node', will contain value 0 for the initial
> > state.
> > +When you input any temperature you want to update to sysfs node, it
> > +automatically enable emulation mode and current temperature will be
> > +changed into it.
> > =C2=A0
> > -Exynos emulation mode requires synchronous of value changing and
> > enabling. It means when you
> > -want to update the any value of delay or next temperature, then you
> > have to enable emulation
> > -mode at the same time. (Or you have to keep the mode enabling.) If
> > you don't, it fails to
> > -change the value to updated one and just use last succeessful value
> > repeatedly. That's why
> > -this node gives users the right to change termerpature only. Just
> > one interface makes it more
> > -simply to use.
> > +(Exynos also supports user changeable delay time which would be used
> > to
> > +delay of changing temperature. However, this node only uses same
> > delay
> > +of real sensing time, 938us.)
> > +
> > +Exynos emulation mode requires synchronous of value changing and
> > +enabling. It means when you want to update the any value of delay or
> > +next temperature, then you have to enable emulation mode at the same
> > +time. (Or you have to keep the mode enabling.) If you don't, it
> > fails to
> > +change the value to updated one and just use last succeessful value
> > +repeatedly. That's why this node gives users the right to change
> > +termerpature only. Just one interface makes it more simply to use.
> > =C2=A0
> > =C2=A0Disabling emulation mode only requires writing value 0 to sysfs
> > node.
> > =C2=A0
> > +::
> > =C2=A0
> > -TEMP	120 |
> > +
> > +=C2=A0=C2=A0TEMP	120 |
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0|
> > =C2=A0	100 |
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0|
> > =C2=A0	=C2=A080 |
> > -	=C2=A0=C2=A0=C2=A0=C2=A0|		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	=C2=A0	=C2=
=A0+-----------
> > -	=C2=A060 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0	=C2=A0|	=C2=A0=C2=A0=C2=A0=C2=A0|
> > -	=C2=A0=C2=A0=C2=A0=C2=A0|	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0+-------------|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|
> > +	=C2=A0=C2=A0=C2=A0=C2=A0|				=C2=A0+-----------
> > +	=C2=A060 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0			=C2=A0|	=C2=A0=C2=A0=
=C2=A0=C2=A0|
> > +	=C2=A0=C2=A0=C2=A0=C2=A0|		=C2=A0=C2=A0=C2=A0+-------------|=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
> > =C2=A0	=C2=A040 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0	=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|
> > -	=C2=A0=C2=A0=C2=A0=C2=A0|		=C2=A0=C2=A0=C2=A0|	=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0	=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0|
> > -	=C2=A020 |		=C2=A0=C2=A0=C2=A0|	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	=C2=A0=
|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+-
> > ---------
> > -	=C2=A0=C2=A0=C2=A0=C2=A0|	=C2=A0	=C2=A0=C2=A0=C2=A0|	=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0	=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0|
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
> > +	=C2=A0=C2=A0=C2=A0=C2=A0|		=C2=A0=C2=A0=C2=A0|		=C2=A0|=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
> > +	=C2=A020 |		=C2=A0=C2=A0=C2=A0|		=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+----
> > ------
> > +	=C2=A0=C2=A0=C2=A0=C2=A0|		=C2=A0=C2=A0=C2=A0|		=C2=A0|=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0|
> > =C2=A0	=C2=A0=C2=A00
> > |______________|_____________|__________|__________|_________
> > -		=C2=A0=C2=A0=C2=A0A	=C2=A0=C2=A0=C2=A0=C2=A0	=C2=A0A	=C2=A0=C2=A0=C2=
=A0=C2=A0A	=C2=A0=C2=A0=C2=A0=09
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0TIME
> > +		=C2=A0=C2=A0=C2=A0A		=C2=A0A	=C2=A0=C2=A0=C2=A0=C2=A0A		=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TIME
> > =C2=A0		=C2=A0=C2=A0=C2=A0|<----->|	=C2=A0|<----->|=C2=A0=C2=A0|<----->=
|	=C2=A0=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0|
> > =C2=A0		=C2=A0=C2=A0=C2=A0| 938us |=C2=A0=C2=A0	=C2=A0|	=C2=A0|=C2=A0=
=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0|
> > -emulation=C2=A0=C2=A0=C2=A0=C2=A0:=C2=A0=C2=A00=C2=A0=C2=A050	=C2=A0=
=C2=A0=C2=A0|=C2=A0=C2=A0	=C2=A070=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A020=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > -current temp :=C2=A0=C2=A0=C2=A0sensor=C2=A0=C2=A0=C2=A050		=C2=A070=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A020	=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0sensor
> > +=C2=A0=C2=A0emulation=C2=A0=C2=A0=C2=A0: 0=C2=A0=C2=A050	=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A0	=C2=A070=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=
=A020=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A0current temp:=C2=A0=C2=A0=C2=A0sensor=C2=A0=C2=A0=C2=A050	=
	=C2=A070=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A020	=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sensor
> > diff --git a/Documentation/thermal/index.rst
> > b/Documentation/thermal/index.rst
> > new file mode 100644
> > index 000000000000..8c1c00146cad
> > --- /dev/null
> > +++ b/Documentation/thermal/index.rst
> > @@ -0,0 +1,18 @@
> > +:orphan:
> > +
> > +=3D=3D=3D=3D=3D=3D=3D
> > +Thermal
> > +=3D=3D=3D=3D=3D=3D=3D
> > +
> > +.. toctree::
> > +=C2=A0=C2=A0=C2=A0:maxdepth: 1
> > +
> > +=C2=A0=C2=A0=C2=A0cpu-cooling-api
> > +=C2=A0=C2=A0=C2=A0sysfs-api
> > +=C2=A0=C2=A0=C2=A0power_allocator
> > +
> > +=C2=A0=C2=A0=C2=A0exynos_thermal
> > +=C2=A0=C2=A0=C2=A0exynos_thermal_emulation
> > +=C2=A0=C2=A0=C2=A0intel_powerclamp
> > +=C2=A0=C2=A0=C2=A0nouveau_thermal
> > +=C2=A0=C2=A0=C2=A0x86_pkg_temperature_thermal
> > diff --git a/Documentation/thermal/intel_powerclamp.txt
> > b/Documentation/thermal/intel_powerclamp.rst
> > similarity index 76%
> > rename from Documentation/thermal/intel_powerclamp.txt
> > rename to Documentation/thermal/intel_powerclamp.rst
> > index b5df21168fbc..3f6dfb0b3ea6 100644
> > --- a/Documentation/thermal/intel_powerclamp.txt
> > +++ b/Documentation/thermal/intel_powerclamp.rst
> > @@ -1,10 +1,13 @@
> > -			=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > -			=C2=A0INTEL POWERCLAMP DRIVER
> > -			=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > -By: Arjan van de Ven <arjan@linux.intel.com>
> > -=C2=A0=C2=A0=C2=A0=C2=A0Jacob Pan <jacob.jun.pan@linux.intel.com>
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Intel Powerclamp Driver
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +By:
> > +=C2=A0=C2=A0- Arjan van de Ven <arjan@linux.intel.com>
> > +=C2=A0=C2=A0- Jacob Pan <jacob.jun.pan@linux.intel.com>
> > +
> > +.. Contents:
> > =C2=A0
> > -Contents:
> > =C2=A0	(*) Introduction
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0- Goals and Objectives
> > =C2=A0
> > @@ -23,7 +26,6 @@ Contents:
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0- Generic Thermal Layer (sysfs)
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0- Kernel APIs (TBD)
> > =C2=A0
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0INTRODUCTION
> > =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > @@ -47,7 +49,6 @@ scalability, and user experience. In many cases,
> > clear advantage is
> > =C2=A0shown over taking the CPU offline or modulating the CPU clock.
> > =C2=A0
> > =C2=A0
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0THEORY OF OPERATION
> > =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > @@ -57,11 +58,12 @@ Idle Injection
> > =C2=A0On modern Intel processors (Nehalem or later), package level C-st=
ate
> > =C2=A0residency is available in MSRs, thus also available to the kernel.
> > =C2=A0
> > -These MSRs are:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#define MSR_PKG_C2_RESIDENCY	0x60D
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#define MSR_PKG_C3_RESIDENCY	0x3F8
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#define MSR_PKG_C6_RESIDENCY	0x3F9
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#define MSR_PKG_C7_RESIDENCY	0x3FA
> > +These MSRs are::
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#define MSR_PKG_C2_RESIDENCY=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x60D
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#define MSR_PKG_C3_RESIDENCY=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x3F8
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#define MSR_PKG_C6_RESIDENCY=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x3F9
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#define MSR_PKG_C7_RESIDENCY=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x3FA
> > =C2=A0
> > =C2=A0If the kernel can also inject idle time to the system, then a
> > =C2=A0closed-loop control system can be established that manages package
> > @@ -96,19 +98,21 @@ are not masked. Tests show that the extra wakeups
> > from scheduler tick
> > =C2=A0have a dramatic impact on the effectiveness of the powerclamp dri=
ver
> > =C2=A0on large scale systems (Westmere system with 80 processors).
> > =C2=A0
> > -CPU0
> > -		=C2=A0=C2=A0____________=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0____________
> > -kidle_inject/0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0sleep=C2=A0=C2=A0=
=C2=A0=C2=A0|=C2=A0=C2=A0mwait |=C2=A0=C2=A0sleep=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|
> > -	_________|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|________|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|_______
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0duration
> > -CPU1
> > -		=C2=A0=C2=A0____________=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0____________
> > -kidle_inject/1=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0sleep=C2=A0=C2=A0=
=C2=A0=C2=A0|=C2=A0=C2=A0mwait |=C2=A0=C2=A0sleep=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|
> > -	_________|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|________|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|_______
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0roundup(jiffies, interval)
> > +::
> > +
> > +=C2=A0=C2=A0CPU0
> > +		=C2=A0=C2=A0=C2=A0=C2=A0____________=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0____________
> > +=C2=A0=C2=A0kidle_inject/0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0sleep=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0mwait |=C2=A0=C2=A0sleep=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0|
> > +	=C2=A0=C2=A0_________|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0|________|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|_______
> > +				=C2=A0duration
> > +=C2=A0=C2=A0CPU1
> > +		=C2=A0=C2=A0=C2=A0=C2=A0____________=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0____________
> > +=C2=A0=C2=A0kidle_inject/1=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0sleep=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0mwait |=C2=A0=C2=A0sleep=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0|
> > +	=C2=A0=C2=A0_________|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0|________|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|_______
> > +				^
> > +				|
> > +				|
> > +				roundup(jiffies, interval)
> > =C2=A0
> > =C2=A0Only one CPU is allowed to collect statistics and update global
> > =C2=A0control parameters. This CPU is referred to as the controlling CPU
> > in
> > @@ -148,7 +152,7 @@ b) determine the amount of compensation needed at
> > each target ratio
> > =C2=A0
> > =C2=A0Compensation to each target ratio consists of two parts:
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0a) steady state error =
compensation
> > +	a) steady state error compensation
> > =C2=A0	This is to offset the error occurring when the system can
> > =C2=A0	enter idle without extra wakeups (such as external
> > interrupts).
> > =C2=A0
> > @@ -158,41 +162,42 @@ Compensation to each target ratio consists of
> > two parts:
> > =C2=A0	slowing down CPU activities.
> > =C2=A0
> > =C2=A0A debugfs file is provided for the user to examine compensation
> > -progress and results, such as on a Westmere system.
> > -[jacob@nex01 ~]$ cat
> > -/sys/kernel/debug/intel_powerclamp/powerclamp_calib
> > -controlling cpu: 0
> > -pct confidence steady dynamic (compensation)
> > -0	0	0	0
> > -1	1	0	0
> > -2	1	1	0
> > -3	3	1	0
> > -4	3	1	0
> > -5	3	1	0
> > -6	3	1	0
> > -7	3	1	0
> > -8	3	1	0
> > -...
> > -30	3	2	0
> > -31	3	2	0
> > -32	3	1	0
> > -33	3	2	0
> > -34	3	1	0
> > -35	3	2	0
> > -36	3	1	0
> > -37	3	2	0
> > -38	3	1	0
> > -39	3	2	0
> > -40	3	3	0
> > -41	3	1	0
> > -42	3	2	0
> > -43	3	1	0
> > -44	3	1	0
> > -45	3	2	0
> > -46	3	3	0
> > -47	3	0	0
> > -48	3	2	0
> > -49	3	3	0
> > +progress and results, such as on a Westmere system::
> > +
> > +=C2=A0=C2=A0[jacob@nex01 ~]$ cat
> > +=C2=A0=C2=A0/sys/kernel/debug/intel_powerclamp/powerclamp_calib
> > +=C2=A0=C2=A0controlling cpu: 0
> > +=C2=A0=C2=A0pct confidence steady dynamic (compensation)
> > +=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A04=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A05=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A06=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A07=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A08=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A0...
> > +=C2=A0=C2=A030=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A031=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A032=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A033=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A034=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A035=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A036=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A037=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A038=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A039=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A040=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A041=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A042=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A043=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A044=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A045=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A046=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A047=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A048=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +=C2=A0=C2=A049=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > =C2=A0
> > =C2=A0Calibration occurs during runtime. No offline method is available.
> > =C2=A0Steady state compensation is used only when confidence levels of =
all
> > @@ -217,9 +222,8 @@ keeps track of clamping kernel threads, even
> > after they are migrated
> > =C2=A0to other CPUs, after a CPU offline event.
> > =C2=A0
> > =C2=A0
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0Performance Analysis
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0This section describes the general performance data collected on
> > =C2=A0multiple systems, including Westmere (80P) and Ivy Bridge (4P, 8P=
).
> > =C2=A0
> > @@ -257,16 +261,15 @@ achieve up to 40% better performance per watt.
> > (measured by a spin
> > =C2=A0counter summed over per CPU counting threads spawned for all runn=
ing
> > =C2=A0CPUs).
> > =C2=A0
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0Usage and Interfaces
> > =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0The powerclamp driver is registered to the generic thermal layer =
as
> > a
> > -cooling device. Currently, it=E2=80=99s not bound to any thermal zones.
> > +cooling device. Currently, it=E2=80=99s not bound to any thermal zones=
::
> > =C2=A0
> > -jacob@chromoly:/sys/class/thermal/cooling_device14$ grep . *
> > -cur_state:0
> > -max_state:50
> > -type:intel_powerclamp
> > +=C2=A0=C2=A0jacob@chromoly:/sys/class/thermal/cooling_device14$ grep .=
 *
> > +=C2=A0=C2=A0cur_state:0
> > +=C2=A0=C2=A0max_state:50
> > +=C2=A0=C2=A0type:intel_powerclamp
> > =C2=A0
> > =C2=A0cur_state allows user to set the desired idle percentage. Writing=
 0
> > to
> > =C2=A0cur_state will stop idle injection. Writing a value between 1 and
> > @@ -278,9 +281,9 @@ cur_state returns value -1 instead of 0 which is
> > to avoid confusing
> > =C2=A0100% busy state with the disabled state.
> > =C2=A0
> > =C2=A0Example usage:
> > -- To inject 25% idle time
> > -$ sudo sh -c "echo 25 >
> > /sys/class/thermal/cooling_device80/cur_state
> > -"
> > +- To inject 25% idle time::
> > +
> > +	$ sudo sh -c "echo 25 >
> > /sys/class/thermal/cooling_device80/cur_state
> > =C2=A0
> > =C2=A0If the system is not busy and has more than 25% idle time already,
> > =C2=A0then the powerclamp driver will not start idle injection. Using T=
op
> > @@ -292,23 +295,23 @@ idle time is accounted as normal idle in that
> > common code path is
> > =C2=A0taken as the idle task.
> > =C2=A0
> > =C2=A0In this example, 24.1% idle is shown. This helps the system admin=
 or
> > -user determine the cause of slowdown, when a powerclamp driver is in
> > action.
> > +user determine the cause of slowdown, when a powerclamp driver is in
> > action::
> > =C2=A0
> > =C2=A0
> > -Tasks: 197 total,=C2=A0=C2=A0=C2=A01 running, 196 sleeping,=C2=A0=C2=
=A0=C2=A00 stopped,=C2=A0=C2=A0=C2=A00 zombie
> > -Cpu(s): 71.2%us,=C2=A0=C2=A04.7%sy,=C2=A0=C2=A00.0%ni,
> > 24.1%id,=C2=A0=C2=A00.0%wa,=C2=A0=C2=A00.0%hi,=C2=A0=C2=A00.0%si,=C2=A0=
=C2=A00.0%st
> > -Mem:=C2=A0=C2=A0=C2=A03943228k total,=C2=A0=C2=A01689632k used,=C2=A0=
=C2=A02253596k free,=C2=A0=C2=A0=C2=A0=C2=A074960k
> > buffers
> > -Swap:=C2=A0=C2=A04087804k total,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A00k used,=C2=A0=C2=A04087804k free,=C2=A0=C2=A0=C2=A0945336k
> > cached
> > +=C2=A0=C2=A0Tasks: 197 total,=C2=A0=C2=A0=C2=A01 running, 196 sleeping=
,=C2=A0=C2=A0=C2=A00 stopped,=C2=A0=C2=A0=C2=A00
> > zombie
> > +=C2=A0=C2=A0Cpu(s): 71.2%us,=C2=A0=C2=A04.7%sy,=C2=A0=C2=A00.0%ni,
> > 24.1%id,=C2=A0=C2=A00.0%wa,=C2=A0=C2=A00.0%hi,=C2=A0=C2=A00.0%si,=C2=A0=
=C2=A00.0%st
> > +=C2=A0=C2=A0Mem:=C2=A0=C2=A0=C2=A03943228k total,=C2=A0=C2=A01689632k =
used,=C2=A0=C2=A02253596k free,=C2=A0=C2=A0=C2=A0=C2=A074960k
> > buffers
> > +=C2=A0=C2=A0Swap:=C2=A0=C2=A04087804k total,=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A00k used,=C2=A0=C2=A04087804k free,=C2=A0=C2=A0=C2=
=A0945336k
> > cached
> > =C2=A0
> > -=C2=A0=C2=A0PID USER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PR=C2=A0=C2=A0=
NI=C2=A0=C2=A0VIRT=C2=A0=C2=A0RES=C2=A0=C2=A0SHR S %CPU %MEM=C2=A0=C2=A0=C2=
=A0=C2=A0TIME+=C2=A0=C2=A0COMMAND
> > - 3352 jacob=C2=A0=C2=A0=C2=A0=C2=A0=C2=A020=C2=A0=C2=A0=C2=A00=C2=A0=
=C2=A0262m=C2=A0=C2=A0644=C2=A0=C2=A0428 S=C2=A0=C2=A0286=C2=A0=C2=A00.0=C2=
=A0=C2=A0=C2=A00:17.16 spin
> > - 3341 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-51=C2=A0=C2=A0=C2=A00=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A00=
 D=C2=A0=C2=A0=C2=A025=C2=A0=C2=A00.0=C2=A0=C2=A0=C2=A00:01.62
> > kidle_inject/0
> > - 3344 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-51=C2=A0=C2=A0=C2=A00=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A00=
 D=C2=A0=C2=A0=C2=A025=C2=A0=C2=A00.0=C2=A0=C2=A0=C2=A00:01.60
> > kidle_inject/3
> > - 3342 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-51=C2=A0=C2=A0=C2=A00=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A00=
 D=C2=A0=C2=A0=C2=A025=C2=A0=C2=A00.0=C2=A0=C2=A0=C2=A00:01.61
> > kidle_inject/1
> > - 3343 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-51=C2=A0=C2=A0=C2=A00=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A00=
 D=C2=A0=C2=A0=C2=A025=C2=A0=C2=A00.0=C2=A0=C2=A0=C2=A00:01.60
> > kidle_inject/2
> > - 2935 jacob=C2=A0=C2=A0=C2=A0=C2=A0=C2=A020=C2=A0=C2=A0=C2=A00=C2=A0=
=C2=A0696m 125m=C2=A0=C2=A035m S=C2=A0=C2=A0=C2=A0=C2=A05=C2=A0=C2=A03.3=C2=
=A0=C2=A0=C2=A00:31.11 firefox
> > - 1546 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A020=C2=A0=C2=A0=C2=A00=C2=
=A0=C2=A0158m=C2=A0=C2=A020m 6640 S=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A00.5=
=C2=A0=C2=A0=C2=A00:26.97 Xorg
> > - 2100 jacob=C2=A0=C2=A0=C2=A0=C2=A0=C2=A020=C2=A0=C2=A0=C2=A00 1223m=
=C2=A0=C2=A088m=C2=A0=C2=A030m S=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A02.3=C2=
=A0=C2=A0=C2=A00:23.68 compiz
> > +=C2=A0=C2=A0=C2=A0=C2=A0PID USER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PR=
=C2=A0=C2=A0NI=C2=A0=C2=A0VIRT=C2=A0=C2=A0RES=C2=A0=C2=A0SHR S %CPU
> > %MEM=C2=A0=C2=A0=C2=A0=C2=A0TIME+=C2=A0=C2=A0COMMAND
> > +=C2=A0=C2=A0=C2=A03352 jacob=C2=A0=C2=A0=C2=A0=C2=A0=C2=A020=C2=A0=C2=
=A0=C2=A00=C2=A0=C2=A0262m=C2=A0=C2=A0644=C2=A0=C2=A0428 S=C2=A0=C2=A0286=
=C2=A0=C2=A00.0=C2=A0=C2=A0=C2=A00:17.16 spin
> > +=C2=A0=C2=A0=C2=A03341 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-51=C2=A0=C2=
=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=
=A0=C2=A0=C2=A00 D=C2=A0=C2=A0=C2=A025=C2=A0=C2=A00.0=C2=A0=C2=A0=C2=A00:01=
.62
> > kidle_inject/0
> > +=C2=A0=C2=A0=C2=A03344 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-51=C2=A0=C2=
=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=
=A0=C2=A0=C2=A00 D=C2=A0=C2=A0=C2=A025=C2=A0=C2=A00.0=C2=A0=C2=A0=C2=A00:01=
.60
> > kidle_inject/3
> > +=C2=A0=C2=A0=C2=A03342 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-51=C2=A0=C2=
=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=
=A0=C2=A0=C2=A00 D=C2=A0=C2=A0=C2=A025=C2=A0=C2=A00.0=C2=A0=C2=A0=C2=A00:01=
.61
> > kidle_inject/1
> > +=C2=A0=C2=A0=C2=A03343 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-51=C2=A0=C2=
=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=
=A0=C2=A0=C2=A00 D=C2=A0=C2=A0=C2=A025=C2=A0=C2=A00.0=C2=A0=C2=A0=C2=A00:01=
.60
> > kidle_inject/2
> > +=C2=A0=C2=A0=C2=A02935 jacob=C2=A0=C2=A0=C2=A0=C2=A0=C2=A020=C2=A0=C2=
=A0=C2=A00=C2=A0=C2=A0696m 125m=C2=A0=C2=A035m S=C2=A0=C2=A0=C2=A0=C2=A05=
=C2=A0=C2=A03.3=C2=A0=C2=A0=C2=A00:31.11
> > firefox
> > +=C2=A0=C2=A0=C2=A01546 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A020=C2=
=A0=C2=A0=C2=A00=C2=A0=C2=A0158m=C2=A0=C2=A020m 6640 S=C2=A0=C2=A0=C2=A0=C2=
=A03=C2=A0=C2=A00.5=C2=A0=C2=A0=C2=A00:26.97 Xorg
> > +=C2=A0=C2=A0=C2=A02100 jacob=C2=A0=C2=A0=C2=A0=C2=A0=C2=A020=C2=A0=C2=
=A0=C2=A00 1223m=C2=A0=C2=A088m=C2=A0=C2=A030m S=C2=A0=C2=A0=C2=A0=C2=A03=
=C2=A0=C2=A02.3=C2=A0=C2=A0=C2=A00:23.68
> > compiz
> > =C2=A0
> > =C2=A0Tests have shown that by using the powerclamp driver as a cooling
> > =C2=A0device, a PID based userspace thermal controller can manage to
> > diff --git a/Documentation/thermal/nouveau_thermal
> > b/Documentation/thermal/nouveau_thermal.rst
> > similarity index 64%
> > rename from Documentation/thermal/nouveau_thermal
> > rename to Documentation/thermal/nouveau_thermal.rst
> > index 6e17a11efcb0..37255fd6735d 100644
> > --- a/Documentation/thermal/nouveau_thermal
> > +++ b/Documentation/thermal/nouveau_thermal.rst
> > @@ -1,13 +1,15 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0Kernel driver nouveau
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > =C2=A0Supported chips:
> > +
> > =C2=A0* NV43+
> > =C2=A0
> > =C2=A0Authors: Martin Peres (mupuf) <martin.peres@free.fr>
> > =C2=A0
> > =C2=A0Description
> > ----------
> > +-----------
> > =C2=A0
> > =C2=A0This driver allows to read the GPU core temperature, drive the GPU
> > fan and
> > =C2=A0set temperature alarms.
> > @@ -19,20 +21,25 @@ interface is likely not to work. This document
> > may then not cover your situation
> > =C2=A0entirely.
> > =C2=A0
> > =C2=A0Temperature management
> > ---------------------
> > +----------------------
> > =C2=A0
> > =C2=A0Temperature is exposed under as a read-only HWMON attribute
> > temp1_input.
> > =C2=A0
> > =C2=A0In order to protect the GPU from overheating, Nouveau supports 4
> > configurable
> > =C2=A0temperature thresholds:
> > =C2=A0
> > - * Fan_boost: Fan speed is set to 100% when reaching this
> > temperature;
> > - * Downclock: The GPU will be downclocked to reduce its power
> > dissipation;
> > - * Critical: The GPU is put on hold to further lower power
> > dissipation;
> > - * Shutdown: Shut the computer down to protect your GPU.
> > + * Fan_boost:
> > +	Fan speed is set to 100% when reaching this temperature;
> > + * Downclock:
> > +	The GPU will be downclocked to reduce its power dissipation;
> > + * Critical:
> > +	The GPU is put on hold to further lower power dissipation;
> > + * Shutdown:
> > +	Shut the computer down to protect your GPU.
> > =C2=A0
> > -WARNING: Some of these thresholds may not be used by Nouveau
> > depending
> > -on your chipset.
> > +WARNING:
> > +	Some of these thresholds may not be used by Nouveau
> > depending
> > +	on your chipset.
> > =C2=A0
> > =C2=A0The default value for these thresholds comes from the GPU's vbios.
> > These
> > =C2=A0thresholds can be configured thanks to the following HWMON
> > attributes:
> > @@ -46,19 +53,24 @@ NOTE: Remember that the values are stored as
> > milli degrees Celsius. Don't forget
> > =C2=A0to multiply!
> > =C2=A0
> > =C2=A0Fan management
> > -------------
> > +--------------
> > =C2=A0
> > =C2=A0Not all cards have a drivable fan. If you do, then the following
> > HWMON
> > =C2=A0attributes should be available:
> > =C2=A0
> > - * pwm1_enable: Current fan management mode (NONE, MANUAL or AUTO);
> > - * pwm1: Current PWM value (power percentage);
> > - * pwm1_min: The minimum PWM speed allowed;
> > - * pwm1_max: The maximum PWM speed allowed (bypassed when hitting
> > Fan_boost);
> > + * pwm1_enable:
> > +	Current fan management mode (NONE, MANUAL or AUTO);
> > + * pwm1:
> > +	Current PWM value (power percentage);
> > + * pwm1_min:
> > +	The minimum PWM speed allowed;
> > + * pwm1_max:
> > +	The maximum PWM speed allowed (bypassed when hitting
> > Fan_boost);
> > =C2=A0
> > =C2=A0You may also have the following attribute:
> > =C2=A0
> > - * fan1_input: Speed in RPM of your fan.
> > + * fan1_input:
> > +	Speed in RPM of your fan.
> > =C2=A0
> > =C2=A0Your fan can be driven in different modes:
> > =C2=A0
> > @@ -66,14 +78,16 @@ Your fan can be driven in different modes:
> > =C2=A0 * 1: The fan can be driven in manual (use pwm1 to change the
> > speed);
> > =C2=A0 * 2; The fan is driven automatically depending on the temperatur=
e.
> > =C2=A0
> > -NOTE: Be sure to use the manual mode if you want to drive the fan
> > speed manually
> > +NOTE:
> > +=C2=A0=C2=A0Be sure to use the manual mode if you want to drive the fa=
n speed
> > manually
> > =C2=A0
> > -NOTE2: When operating in manual mode outside the vbios-defined
> > -[PWM_min, PWM_max] range, the reported fan speed (RPM) may not be
> > accurate
> > -depending on your hardware.
> > +NOTE2:
> > +=C2=A0=C2=A0When operating in manual mode outside the vbios-defined
> > +=C2=A0=C2=A0[PWM_min, PWM_max] range, the reported fan speed (RPM) may=
 not be
> > accurate
> > +=C2=A0=C2=A0depending on your hardware.
> > =C2=A0
> > =C2=A0Bug reports
> > ----------
> > +-----------
> > =C2=A0
> > =C2=A0Thermal management on Nouveau is new and may not work on all card=
s.
> > If you have
> > =C2=A0inquiries, please ping mupuf on IRC (#nouveau, freenode).
> > diff --git a/Documentation/thermal/power_allocator.txt
> > b/Documentation/thermal/power_allocator.rst
> > similarity index 74%
> > rename from Documentation/thermal/power_allocator.txt
> > rename to Documentation/thermal/power_allocator.rst
> > index 9fb0ff06dca9..67b6a3297238 100644
> > --- a/Documentation/thermal/power_allocator.txt
> > +++ b/Documentation/thermal/power_allocator.rst
> > @@ -1,3 +1,4 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0Power allocator governor tunables
> > =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > @@ -25,36 +26,36 @@ temperature as the control input and power as the
> > controlled output:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0P_max =3D k_p * e + k_i * err_integral + =
k_d * diff_err +
> > sustainable_power
> > =C2=A0
> > =C2=A0where
> > -=C2=A0=C2=A0=C2=A0=C2=A0e =3D desired_temperature - current_temperature
> > -=C2=A0=C2=A0=C2=A0=C2=A0err_integral is the sum of previous errors
> > -=C2=A0=C2=A0=C2=A0=C2=A0diff_err =3D e - previous_error
> > +=C2=A0=C2=A0=C2=A0-=C2=A0=C2=A0e =3D desired_temperature - current_tem=
perature
> > +=C2=A0=C2=A0=C2=A0-=C2=A0=C2=A0err_integral is the sum of previous err=
ors
> > +=C2=A0=C2=A0=C2=A0-=C2=A0=C2=A0diff_err =3D e - previous_error
> > =C2=A0
> > -It is similar to the one depicted below:
> > +It is similar to the one depicted below::
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0k_d
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|
> > -current_temp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0v
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+----------+=C2=A0=
=C2=A0=C2=A0+---+
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0+----->| diff_err |-->| X |------+
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+----------+=C2=A0=C2=
=A0=C2=A0+---+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0tdp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
ac
> > tor
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
k_i=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0get_reque
> > sted_power()
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=
=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0|
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=
=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0| ...
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0v=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0v=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0v=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0v=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0v=
=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0v
> > -=C2=A0=C2=A0=C2=A0+---+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+-------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0+---+=C2=A0=C2=A0=C2=A0=C2=A0+---+=C2=A0=C2=A0=C2=A0+---+=C2=A0=C2=A0=C2=
=A0+-----
> > -----+
> > -=C2=A0=C2=A0=C2=A0| S |-------+----->| sum e |----->| X |--->| S |-->|=
 S | =20
> > -->|power=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =20
> > -=C2=A0=C2=A0=C2=A0+---+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+-------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0+---+=C2=A0=C2=A0=C2=A0=C2=A0+---+=C2=A0=C2=A0=C2=A0+---
> > +=C2=A0=C2=A0=C2=A0|allocation|
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+-----
> > -----+
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0|=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0|
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+---
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0|
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0+------->| X |-------------------
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0v=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0v
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+---+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0granted
> > performance
> > -desired_temperature=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0|
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0|
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0k_po/k_pu
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0k_d
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
> > +=C2=A0=C2=A0current_temp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0v
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+----------+=C2=A0=
=C2=A0=C2=A0+---+
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0+----->| diff_err |-->| X |------+
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+----------+=C2=A0=C2=
=A0=C2=A0+---+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0tdp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
ac
> > tor
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
k_i=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0get_reque
> > sted_power()
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=
=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0|
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=
=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0| ...
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0v=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0v=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0v=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0v=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0v=
=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0v
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+---+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+-------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0+---+=C2=A0=C2=A0=C2=A0=C2=A0+---+=C2=A0=C2=A0=C2=A0+---+=C2=A0=C2=A0=C2=
=A0+-----
> > -----+
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| S |-----+----->| sum e |----->| X |---=
>| S |-->| S | =20
> > -->|power=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+---+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+-------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0+---+=C2=A0=C2=A0=C2=A0=C2=A0+---+=C2=A0=C2=A0=C2=A0+---
> > +=C2=A0=C2=A0=C2=A0|allocation|
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+-----
> > -----+
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0|=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0|
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+---
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0|
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0+------->| X |-------------------
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0v=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0v
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+---+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0granted
> > performance
> > +=C2=A0=C2=A0desired_temperature=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
> > +			=C2=A0=C2=A0|
> > +			=C2=A0=C2=A0|
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0k_po/k_pu
> > =C2=A0
> > =C2=A0Sustainable power
> > =C2=A0-----------------
> > @@ -73,7 +74,7 @@ is typically 2000mW, while on a 10" tablet is
> > around 4500mW (may vary
> > =C2=A0depending on screen size).
> > =C2=A0
> > =C2=A0If you are using device tree, do add it as a property of the
> > -thermal-zone.=C2=A0=C2=A0For example:
> > +thermal-zone.=C2=A0=C2=A0For example::
> > =C2=A0
> > =C2=A0	thermal-zones {
> > =C2=A0		soc_thermal {
> > @@ -85,7 +86,7 @@ thermal-zone.=C2=A0=C2=A0For example:
> > =C2=A0Instead, if the thermal zone is registered from the platform code,
> > pass a
> > =C2=A0`thermal_zone_params` that has a `sustainable_power`.=C2=A0=C2=A0=
If no
> > =C2=A0`thermal_zone_params` were being passed, then something like below
> > -will suffice:
> > +will suffice::
> > =C2=A0
> > =C2=A0	static const struct thermal_zone_params tz_params =3D {
> > =C2=A0		.sustainable_power =3D 3500,
> > @@ -112,18 +113,18 @@ available capacity at a low temperature.=C2=A0=C2=
=A0On
> > the other hand, a high
> > =C2=A0value of `k_pu` will result in the governor granting very high po=
wer
> > =C2=A0while temperature is low, and may lead to temperature overshootin=
g.
> > =C2=A0
> > -The default value for `k_pu` is:
> > +The default value for `k_pu` is::
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A02 * sustainable_power / (desired_temperat=
ure - switch_on_temp)
> > =C2=A0
> > =C2=A0This means that at `switch_on_temp` the output of the controller's
> > =C2=A0proportional term will be 2 * `sustainable_power`.=C2=A0=C2=A0The=
 default
> > value
> > -for `k_po` is:
> > +for `k_po` is::
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sustainable_power / (desired_temperature =
- switch_on_temp)
> > =C2=A0
> > =C2=A0Focusing on the proportional and feed forward values of the PID
> > -controller equation we have:
> > +controller equation we have::
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0P_max =3D k_p * e + sustainable_power
> > =C2=A0
> > @@ -134,21 +135,23 @@ is the desired one, then the proportional
> > component is zero and
> > =C2=A0thermal equilibrium under constant load.=C2=A0=C2=A0`sustainable_=
power` is
> > only
> > =C2=A0an estimate, which is the reason for closed-loop control such as
> > this.
> > =C2=A0
> > -Expanding `k_pu` we get:
> > +Expanding `k_pu` we get::
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0P_max =3D 2 * sustainable_power * (T_set =
- T) / (T_set - T_on) +
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sustainable_power
> > +	sustainable_power
> > =C2=A0
> > -where
> > -=C2=A0=C2=A0=C2=A0=C2=A0T_set is the desired temperature
> > -=C2=A0=C2=A0=C2=A0=C2=A0T is the current temperature
> > -=C2=A0=C2=A0=C2=A0=C2=A0T_on is the switch on temperature
> > +where:
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0- T_set is the desired temperature
> > +=C2=A0=C2=A0=C2=A0=C2=A0- T is the current temperature
> > +=C2=A0=C2=A0=C2=A0=C2=A0- T_on is the switch on temperature
> > =C2=A0
> > =C2=A0When the current temperature is the switch_on temperature, the ab=
ove
> > -formula becomes:
> > +formula becomes::
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0P_max =3D 2 * sustainable_power * (T_set =
- T_on) / (T_set - T_on)
> > +
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sustainable_power =3D =
2 * sustainable_power +
> > sustainable_power =3D
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03 * sustainable_power
> > +	sustainable_power =3D 2 * sustainable_power +
> > sustainable_power =3D
> > +	3 * sustainable_power
> > =C2=A0
> > =C2=A0Therefore, the proportional term alone linearly decreases power f=
rom
> > =C2=A03 * `sustainable_power` to `sustainable_power` as the temperature
> > @@ -178,11 +181,18 @@ Cooling device power API
> > =C2=A0Cooling devices controlled by this governor must supply the
> > additional
> > =C2=A0"power" API in their `cooling_device_ops`.=C2=A0=C2=A0It consists=
 on three
> > ops:
> > =C2=A0
> > -1. int get_requested_power(struct thermal_cooling_device *cdev,
> > -	struct thermal_zone_device *tz, u32 *power);
> > -@cdev: The `struct thermal_cooling_device` pointer
> > -@tz: thermal zone in which we are currently operating
> > -@power: pointer in which to store the calculated power
> > +1. ::
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0int get_requested_power(struct thermal_cooling=
_device *cdev,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0struct thermal_zone_device *tz, u32
> > *power);
> > +
> > +
> > +@cdev:
> > +	The `struct thermal_cooling_device` pointer
> > +@tz:
> > +	thermal zone in which we are currently operating
> > +@power:
> > +	pointer in which to store the calculated power
> > =C2=A0
> > =C2=A0`get_requested_power()` calculates the power requested by the dev=
ice
> > =C2=A0in milliwatts and stores it in @power .=C2=A0=C2=A0It should retu=
rn 0 on
> > @@ -190,23 +200,37 @@ success, -E* on failure.=C2=A0=C2=A0This is curre=
ntly
> > used by the power
> > =C2=A0allocator governor to calculate how much power to give to each
> > cooling
> > =C2=A0device.
> > =C2=A0
> > -2. int state2power(struct thermal_cooling_device *cdev, struct
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0thermal_zone_device *t=
z, unsigned long state, u32 *power);
> > -@cdev: The `struct thermal_cooling_device` pointer
> > -@tz: thermal zone in which we are currently operating
> > -@state: A cooling device state
> > -@power: pointer in which to store the equivalent power
> > +2. ::
> > +
> > +	int state2power(struct thermal_cooling_device *cdev, struct
> > +			thermal_zone_device *tz, unsigned long
> > state,
> > +			u32 *power);
> > +
> > +@cdev:
> > +	The `struct thermal_cooling_device` pointer
> > +@tz:
> > +	thermal zone in which we are currently operating
> > +@state:
> > +	A cooling device state
> > +@power:
> > +	pointer in which to store the equivalent power
> > =C2=A0
> > =C2=A0Convert cooling device state @state into power consumption in
> > =C2=A0milliwatts and store it in @power.=C2=A0=C2=A0It should return 0 =
on success,
> > -E*
> > =C2=A0on failure.=C2=A0=C2=A0This is currently used by thermal core to =
calculate the
> > =C2=A0maximum power that an actor can consume.
> > =C2=A0
> > -3. int power2state(struct thermal_cooling_device *cdev, u32 power,
> > -	unsigned long *state);
> > -@cdev: The `struct thermal_cooling_device` pointer
> > -@power: power in milliwatts
> > -@state: pointer in which to store the resulting state
> > +3. ::
> > +
> > +	int power2state(struct thermal_cooling_device *cdev, u32
> > power,
> > +			unsigned long *state);
> > +
> > +@cdev:
> > +	The `struct thermal_cooling_device` pointer
> > +@power:
> > +	power in milliwatts
> > +@state:
> > +	pointer in which to store the resulting state
> > =C2=A0
> > =C2=A0Calculate a cooling device state that would make the device consu=
me
> > at
> > =C2=A0most @power mW and store it in @state.=C2=A0=C2=A0It should retur=
n 0 on
> > success,
> > diff --git a/Documentation/thermal/sysfs-api.txt
> > b/Documentation/thermal/sysfs-api.rst
> > similarity index 66%
> > rename from Documentation/thermal/sysfs-api.txt
> > rename to Documentation/thermal/sysfs-api.rst
> > index c3fa500df92c..e4930761d3e5 100644
> > --- a/Documentation/thermal/sysfs-api.txt
> > +++ b/Documentation/thermal/sysfs-api.rst
> > @@ -1,3 +1,4 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0Generic Thermal Sysfs driver How To
> > =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > @@ -9,6 +10,7 @@ Copyright (c)=C2=A0=C2=A02008 Intel Corporation
> > =C2=A0
> > =C2=A0
> > =C2=A00. Introduction
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > =C2=A0The generic thermal sysfs provides a set of interfaces for thermal
> > zone
> > =C2=A0devices (sensors) and thermal cooling devices (fan, processor...)=
 to
> > register
> > @@ -25,59 +27,90 @@ An intelligent thermal management application can
> > make decisions based on
> > =C2=A0inputs from thermal zone attributes (the current temperature and
> > trip point
> > =C2=A0temperature) and throttle appropriate devices.
> > =C2=A0
> > -[0-*]	denotes any positive number starting from 0
> > -[1-*]	denotes any positive number starting from 1
> > +- `[0-*]`	denotes any positive number starting from 0
> > +- `[1-*]`	denotes any positive number starting from 1
> > =C2=A0
> > =C2=A01. thermal sysfs driver interface functions
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > =C2=A01.1 thermal zone device interface
> > -1.1.1 struct thermal_zone_device *thermal_zone_device_register(char
> > *type,
> > -		int trips, int mask, void *devdata,
> > -		struct thermal_zone_device_ops *ops,
> > -		const struct thermal_zone_params *tzp,
> > -		int passive_delay, int polling_delay))
> > +---------------------------------
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0::
> > +
> > +	struct thermal_zone_device
> > +	*thermal_zone_device_register(char *type,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int trips, int mask, void
> > *devdata,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct thermal_zone_device_ops
> > *ops,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct
> > thermal_zone_params *tzp,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int passive_delay, int
> > polling_delay))
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This interface function adds a new therma=
l zone device (sensor)
> > to
> > -=C2=A0=C2=A0=C2=A0=C2=A0/sys/class/thermal folder as thermal_zone[0-*]=
. It tries to bind
> > all the
> > +=C2=A0=C2=A0=C2=A0=C2=A0/sys/class/thermal folder as `thermal_zone[0-*=
]`. It tries to
> > bind all the
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0thermal cooling devices registered at the=
 same time.
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0type: the thermal zone type.
> > -=C2=A0=C2=A0=C2=A0=C2=A0trips: the total number of trip points this th=
ermal zone
> > supports.
> > -=C2=A0=C2=A0=C2=A0=C2=A0mask: Bit string: If 'n'th bit is set, then tr=
ip point 'n' is
> > writeable.
> > -=C2=A0=C2=A0=C2=A0=C2=A0devdata: device private data
> > -=C2=A0=C2=A0=C2=A0=C2=A0ops: thermal zone device call-backs.
> > -	.bind: bind the thermal zone device with a thermal cooling
> > device.
> > -	.unbind: unbind the thermal zone device with a thermal
> > cooling device.
> > -	.get_temp: get the current temperature of the thermal zone.
> > -	.set_trips: set the trip points window. Whenever the current
> > temperature
> > +=C2=A0=C2=A0=C2=A0=C2=A0type:
> > +	the thermal zone type.
> > +=C2=A0=C2=A0=C2=A0=C2=A0trips:
> > +	the total number of trip points this thermal zone supports.
> > +=C2=A0=C2=A0=C2=A0=C2=A0mask:
> > +	Bit string: If 'n'th bit is set, then trip point 'n' is
> > writeable.
> > +=C2=A0=C2=A0=C2=A0=C2=A0devdata:
> > +	device private data
> > +=C2=A0=C2=A0=C2=A0=C2=A0ops:
> > +	thermal zone device call-backs.
> > +
> > +	.bind:
> > +		bind the thermal zone device with a thermal cooling
> > device.
> > +	.unbind:
> > +		unbind the thermal zone device with a thermal
> > cooling device.
> > +	.get_temp:
> > +		get the current temperature of the thermal zone.
> > +	.set_trips:
> > +		=C2=A0=C2=A0=C2=A0=C2=A0set the trip points window. Whenever the cur=
rent
> > temperature
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0is updated, the trip points immediately=
 below
> > and above the
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0current temperature are found.
> > -	.get_mode: get the current mode (enabled/disabled) of the
> > thermal zone.
> > -	=C2=A0=C2=A0=C2=A0=C2=A0- "enabled" means the kernel thermal manageme=
nt is
> > enabled.
> > -	=C2=A0=C2=A0=C2=A0=C2=A0- "disabled" will prevent kernel thermal driv=
er action
> > upon trip points
> > -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0so that user applications can tak=
e charge of thermal
> > management.
> > -	.set_mode: set the mode (enabled/disabled) of the thermal
> > zone.
> > -	.get_trip_type: get the type of certain trip point.
> > -	.get_trip_temp: get the temperature above which the certain
> > trip point
> > +	.get_mode:
> > +		=C2=A0=C2=A0=C2=A0get the current mode (enabled/disabled) of the
> > thermal zone.
> > +
> > +			- "enabled" means the kernel thermal
> > management is
> > +			=C2=A0=C2=A0enabled.
> > +			- "disabled" will prevent kernel thermal
> > driver action
> > +			=C2=A0=C2=A0upon trip points so that user applications
> > can take
> > +			=C2=A0=C2=A0charge of thermal management.
> > +	.set_mode:
> > +		set the mode (enabled/disabled) of the thermal zone.
> > +	.get_trip_type:
> > +		get the type of certain trip point.
> > +	.get_trip_temp:
> > +			get the temperature above which the certain
> > trip point
> > =C2=A0			will be fired.
> > -	.set_emul_temp: set the emulation temperature which helps in
> > debugging
> > +	.set_emul_temp:
> > +			set the emulation temperature which helps in
> > debugging
> > =C2=A0			different threshold temperature points.
> > -=C2=A0=C2=A0=C2=A0=C2=A0tzp: thermal zone platform parameters.
> > -=C2=A0=C2=A0=C2=A0=C2=A0passive_delay: number of milliseconds to wait =
between polls when
> > +=C2=A0=C2=A0=C2=A0=C2=A0tzp:
> > +	thermal zone platform parameters.
> > +=C2=A0=C2=A0=C2=A0=C2=A0passive_delay:
> > +	number of milliseconds to wait between polls when
> > =C2=A0	performing passive cooling.
> > -=C2=A0=C2=A0=C2=A0=C2=A0polling_delay: number of milliseconds to wait =
between polls when
> > checking
> > +=C2=A0=C2=A0=C2=A0=C2=A0polling_delay:
> > +	number of milliseconds to wait between polls when checking
> > =C2=A0	whether trip points have been crossed (0 for interrupt
> > driven systems).
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0::
> > =C2=A0
> > -1.1.2 void thermal_zone_device_unregister(struct thermal_zone_device
> > *tz)
> > +	void thermal_zone_device_unregister(struct
> > thermal_zone_device *tz)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This interface function removes the therm=
al zone device.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0It deletes the corresponding entry from /=
sys/class/thermal
> > folder and
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unbinds all the thermal cooling devices i=
t uses.
> > =C2=A0
> > -1.1.3 struct thermal_zone_device *thermal_zone_of_sensor_register(
> > -		struct device *dev, int sensor_id, void *data,
> > -		const struct thermal_zone_of_device_ops *ops)
> > +	::
> > +
> > +	=C2=A0=C2=A0=C2=A0struct thermal_zone_device
> > +	=C2=A0=C2=A0=C2=A0*thermal_zone_of_sensor_register(struct device *dev=
, int
> > sensor_id,
> > +				void *data,
> > +				const struct
> > thermal_zone_of_device_ops *ops)
> > =C2=A0
> > =C2=A0	This interface adds a new sensor to a DT thermal zone.
> > =C2=A0	This function will search the list of thermal zones
> > described in
> > @@ -87,25 +120,33 @@ temperature) and throttle appropriate devices.
> > =C2=A0	thermal zone device.
> > =C2=A0
> > =C2=A0	The parameters for this interface are:
> > -	dev:		Device node of sensor containing valid
> > node pointer in
> > +
> > +	dev:
> > +			Device node of sensor containing valid node
> > pointer in
> > =C2=A0			dev->of_node.
> > -	sensor_id:	a sensor identifier, in case the sensor IP
> > has more
> > +	sensor_id:
> > +			a sensor identifier, in case the sensor IP
> > has more
> > =C2=A0			than one sensors
> > -	data:		a private pointer (owned by the caller)
> > that will be
> > +	data:
> > +			a private pointer (owned by the caller) that
> > will be
> > =C2=A0			passed back, when a temperature reading is
> > needed.
> > -	ops:		struct thermal_zone_of_device_ops *.
> > +	ops:
> > +			`struct thermal_zone_of_device_ops *`.
> > =C2=A0
> > -			get_temp:	a pointer to a function
> > that reads the
> > +			=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=C2=A0=C2=A0=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +			get_temp	a pointer to a function that
> > reads the
> > =C2=A0					sensor temperature. This is
> > mandatory
> > =C2=A0					callback provided by sensor
> > driver.
> > -			set_trips:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0a pointer to a functi=
on that
> > sets a
> > +			set_trips	a pointer to a function
> > that sets a
> > =C2=A0					temperature window. When
> > this window is
> > =C2=A0					left the driver must inform
> > the thermal
> > =C2=A0					core via
> > thermal_zone_device_update.
> > -			get_trend:=C2=A0	a pointer to a function
> > that reads the
> > +			get_trend=C2=A0	a pointer to a function
> > that reads the
> > =C2=A0					sensor temperature trend.
> > -			set_emul_temp:	a pointer to a
> > function that sets
> > +			set_emul_temp	a pointer to a function
> > that sets
> > =C2=A0					sensor emulated temperature.
> > +			=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=C2=A0=C2=A0=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > =C2=A0	The thermal zone temperature is provided by the get_temp()
> > function
> > =C2=A0	pointer of thermal_zone_of_device_ops. When called, it will
> > =C2=A0	have the private pointer @data back.
> > @@ -114,8 +155,10 @@ temperature) and throttle appropriate devices.
> > =C2=A0	handle. Caller should check the return handle with IS_ERR()
> > for finding
> > =C2=A0	whether success or not.
> > =C2=A0
> > -1.1.4 void thermal_zone_of_sensor_unregister(struct device *dev,
> > -		struct thermal_zone_device *tzd)
> > +	::
> > +
> > +	=C2=A0=C2=A0=C2=A0=C2=A0void thermal_zone_of_sensor_unregister(struct=
 device
> > *dev,
> > +						=C2=A0=C2=A0=C2=A0struct
> > thermal_zone_device *tzd)
> > =C2=A0
> > =C2=A0	This interface unregisters a sensor from a DT thermal zone
> > which was
> > =C2=A0	successfully added by interface
> > thermal_zone_of_sensor_register().
> > @@ -124,21 +167,29 @@ temperature) and throttle appropriate devices.
> > =C2=A0	interface. It will also silent the zone by remove the
> > .get_temp() and
> > =C2=A0	get_trend() thermal zone device callbacks.
> > =C2=A0
> > -1.1.5 struct thermal_zone_device
> > *devm_thermal_zone_of_sensor_register(
> > -		struct device *dev, int sensor_id,
> > -		void *data, const struct thermal_zone_of_device_ops
> > *ops)
> > +	::
> > +
> > +	=C2=A0=C2=A0struct thermal_zone_device
> > +	=C2=A0=C2=A0*devm_thermal_zone_of_sensor_register(struct device *dev,
> > +				int sensor_id,
> > +				void *data,
> > +				const struct
> > thermal_zone_of_device_ops *ops)
> > =C2=A0
> > =C2=A0	This interface is resource managed version of
> > =C2=A0	thermal_zone_of_sensor_register().
> > +
> > =C2=A0	All details of thermal_zone_of_sensor_register() described
> > in
> > =C2=A0	section 1.1.3 is applicable here.
> > +
> > =C2=A0	The benefit of using this interface to register sensor is
> > that it
> > =C2=A0	is not require to explicitly call
> > thermal_zone_of_sensor_unregister()
> > =C2=A0	in error path or during driver unbinding as this is done by
> > driver
> > =C2=A0	resource manager.
> > =C2=A0
> > -1.1.6 void devm_thermal_zone_of_sensor_unregister(struct device
> > *dev,
> > -		struct thermal_zone_device *tzd)
> > +	::
> > +
> > +		void devm_thermal_zone_of_sensor_unregister(struct
> > device *dev,
> > +						struct
> > thermal_zone_device *tzd)
> > =C2=A0
> > =C2=A0	This interface is resource managed version of
> > =C2=A0	thermal_zone_of_sensor_unregister().
> > @@ -147,123 +198,186 @@ temperature) and throttle appropriate
> > devices.
> > =C2=A0	Normally this function will not need to be called and the
> > resource
> > =C2=A0	management code will ensure that the resource is freed.
> > =C2=A0
> > -1.1.7 int thermal_zone_get_slope(struct thermal_zone_device *tz)
> > +	::
> > +
> > +		int thermal_zone_get_slope(struct
> > thermal_zone_device *tz)
> > =C2=A0
> > =C2=A0	This interface is used to read the slope attribute value
> > =C2=A0	for the thermal zone device, which might be useful for
> > platform
> > =C2=A0	drivers for temperature calculations.
> > =C2=A0
> > -1.1.8 int thermal_zone_get_offset(struct thermal_zone_device *tz)
> > +	::
> > +
> > +		int thermal_zone_get_offset(struct
> > thermal_zone_device *tz)
> > =C2=A0
> > =C2=A0	This interface is used to read the offset attribute value
> > =C2=A0	for the thermal zone device, which might be useful for
> > platform
> > =C2=A0	drivers for temperature calculations.
> > =C2=A0
> > =C2=A01.2 thermal cooling device interface
> > -1.2.1 struct thermal_cooling_device
> > *thermal_cooling_device_register(char *name,
> > -		void *devdata, struct thermal_cooling_device_ops *)
> > +------------------------------------
> > +
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0::
> > +
> > +	struct thermal_cooling_device
> > +	*thermal_cooling_device_register(char *name,
> > +			void *devdata, struct
> > thermal_cooling_device_ops *)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This interface function adds a new therma=
l cooling device
> > (fan/processor/...)
> > -=C2=A0=C2=A0=C2=A0=C2=A0to /sys/class/thermal/ folder as cooling_devic=
e[0-*]. It tries
> > to bind itself
> > +=C2=A0=C2=A0=C2=A0=C2=A0to /sys/class/thermal/ folder as `cooling_devi=
ce[0-*]`. It tries
> > to bind itself
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0to all the thermal zone devices registere=
d at the same time.
> > -=C2=A0=C2=A0=C2=A0=C2=A0name: the cooling device name.
> > -=C2=A0=C2=A0=C2=A0=C2=A0devdata: device private data.
> > -=C2=A0=C2=A0=C2=A0=C2=A0ops: thermal cooling devices call-backs.
> > -	.get_max_state: get the Maximum throttle state of the
> > cooling device.
> > -	.get_cur_state: get the Currently requested throttle state
> > of the cooling device.
> > -	.set_cur_state: set the Current throttle state of the
> > cooling device.
> > -
> > -1.2.2 void thermal_cooling_device_unregister(struct
> > thermal_cooling_device *cdev)
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0name:
> > +	the cooling device name.
> > +=C2=A0=C2=A0=C2=A0=C2=A0devdata:
> > +	device private data.
> > +=C2=A0=C2=A0=C2=A0=C2=A0ops:
> > +	thermal cooling devices call-backs.
> > +
> > +	.get_max_state:
> > +		get the Maximum throttle state of the cooling
> > device.
> > +	.get_cur_state:
> > +		get the Currently requested throttle state of the
> > +		cooling device.
> > +	.set_cur_state:
> > +		set the Current throttle state of the cooling
> > device.
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0::
> > +
> > +	void thermal_cooling_device_unregister(struct
> > thermal_cooling_device *cdev)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This interface function removes the therm=
al cooling device.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0It deletes the corresponding entry from /=
sys/class/thermal
> > folder and
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unbinds itself from all the thermal zone =
devices using it.
> > =C2=A0
> > =C2=A01.3 interface for binding a thermal zone device with a thermal
> > cooling device
> > -1.3.1 int thermal_zone_bind_cooling_device(struct
> > thermal_zone_device *tz,
> > -	int trip, struct thermal_cooling_device *cdev,
> > -	unsigned long upper, unsigned long lower, unsigned int
> > weight);
> > +------------------------------------------------------------------
> > -----------
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0::
> > +
> > +	int thermal_zone_bind_cooling_device(struct
> > thermal_zone_device *tz,
> > +		int trip, struct thermal_cooling_device *cdev,
> > +		unsigned long upper, unsigned long lower, unsigned
> > int weight);
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This interface function binds a thermal c=
ooling device to a
> > particular trip
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0point of a thermal zone device.
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This function is usually called in the th=
ermal zone device .bind
> > callback.
> > -=C2=A0=C2=A0=C2=A0=C2=A0tz: the thermal zone device
> > -=C2=A0=C2=A0=C2=A0=C2=A0cdev: thermal cooling device
> > -=C2=A0=C2=A0=C2=A0=C2=A0trip: indicates which trip point in this therm=
al zone the
> > cooling device
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0is associa=
ted with.
> > -=C2=A0=C2=A0=C2=A0=C2=A0upper:the Maximum cooling state for this trip =
point.
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0THERMAL_NO=
_LIMIT means no upper limit,
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0tz:
> > +	=C2=A0=C2=A0the thermal zone device
> > +=C2=A0=C2=A0=C2=A0=C2=A0cdev:
> > +	=C2=A0=C2=A0thermal cooling device
> > +=C2=A0=C2=A0=C2=A0=C2=A0trip:
> > +	=C2=A0=C2=A0indicates which trip point in this thermal zone the
> > cooling device
> > +	=C2=A0=C2=A0is associated with.
> > +=C2=A0=C2=A0=C2=A0=C2=A0upper:
> > +	=C2=A0=C2=A0the Maximum cooling state for this trip point.
> > +	=C2=A0=C2=A0THERMAL_NO_LIMIT means no upper limit,
> > =C2=A0	=C2=A0=C2=A0and the cooling device can be in max_state.
> > -=C2=A0=C2=A0=C2=A0=C2=A0lower:the Minimum cooling state can be used fo=
r this trip point.
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0THERMAL_NO=
_LIMIT means no lower limit,
> > +=C2=A0=C2=A0=C2=A0=C2=A0lower:
> > +	=C2=A0=C2=A0the Minimum cooling state can be used for this trip point.
> > +	=C2=A0=C2=A0THERMAL_NO_LIMIT means no lower limit,
> > =C2=A0	=C2=A0=C2=A0and the cooling device can be in cooling state 0.
> > -=C2=A0=C2=A0=C2=A0=C2=A0weight: the influence of this cooling device i=
n this thermal
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0zone.=C2=A0=C2=A0See 1.4.1 below for more information.
> > +=C2=A0=C2=A0=C2=A0=C2=A0weight:
> > +	=C2=A0=C2=A0the influence of this cooling device in this thermal
> > +	=C2=A0=C2=A0zone.=C2=A0=C2=A0See 1.4.1 below for more information.
> > =C2=A0
> > -1.3.2 int thermal_zone_unbind_cooling_device(struct
> > thermal_zone_device *tz,
> > -		int trip, struct thermal_cooling_device *cdev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0::
> > +
> > +	int thermal_zone_unbind_cooling_device(struct
> > thermal_zone_device *tz,
> > +				int trip, struct
> > thermal_cooling_device *cdev);
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This interface function unbinds a thermal=
 cooling device from a
> > particular
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trip point of a thermal zone device. This=
 function is usually
> > called in
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0the thermal zone device .unbind callback.
> > -=C2=A0=C2=A0=C2=A0=C2=A0tz: the thermal zone device
> > -=C2=A0=C2=A0=C2=A0=C2=A0cdev: thermal cooling device
> > -=C2=A0=C2=A0=C2=A0=C2=A0trip: indicates which trip point in this therm=
al zone the
> > cooling device
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0is associa=
ted with.
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0tz:
> > +	the thermal zone device
> > +=C2=A0=C2=A0=C2=A0=C2=A0cdev:
> > +	thermal cooling device
> > +=C2=A0=C2=A0=C2=A0=C2=A0trip:
> > +	indicates which trip point in this thermal zone the cooling
> > device
> > +	is associated with.
> > =C2=A0
> > =C2=A01.4 Thermal Zone Parameters
> > -1.4.1 struct thermal_bind_params
> > +---------------------------
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0::
> > +
> > +	struct thermal_bind_params
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This structure defines the following para=
meters that are used to
> > bind
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0a zone with a cooling device for a partic=
ular trip point.
> > -=C2=A0=C2=A0=C2=A0=C2=A0.cdev: The cooling device pointer
> > -=C2=A0=C2=A0=C2=A0=C2=A0.weight: The 'influence' of a particular cooli=
ng device on this
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0zone. This is relative to the rest of the cooling
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0devices. For example, if all cooling devices have a
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0weight of 1, then they all contribute the same. You can
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0use percentages if you want, but it's not mandatory. A
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0weight of 0 means that this cooling device doesn't
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0contribute to the cooling of this zone unless all
> > cooling
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0devices have a weight of 0. If all weights are 0, then
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0they all contribute the same.
> > -=C2=A0=C2=A0=C2=A0=C2=A0.trip_mask:This is a bit mask that gives the b=
inding relation
> > between
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0this thermal zone and cdev, for a particular trip
> > point.
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0If nth bit is set, then the cdev and thermal zone are
> > bound
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0for trip point n.
> > -=C2=A0=C2=A0=C2=A0=C2=A0.binding_limits: This is an array of cooling s=
tate limits. Must
> > have
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0exactly 2 * therma=
l_zone.number_of_trip_points.
> > It is an
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array consisting o=
f tuples <lower-state upper- =20
> > state> of =20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0state limits. Each=
 trip will be associated with
> > one state
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0limit tuple when b=
inding. A NULL pointer means
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<THERMAL_NO_LIMITS=
 THERMAL_NO_LIMITS> on all
> > trips.
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0These limits are u=
sed when binding a cdev to a
> > trip point.
> > -=C2=A0=C2=A0=C2=A0=C2=A0.match: This call back returns success(0) if t=
he 'tz and cdev'
> > need to
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0.cdev:
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0The cooling device pointer
> > +=C2=A0=C2=A0=C2=A0=C2=A0.weight:
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0The 'influence' of a particular cooling=
 device on this
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0zone. This is relative to the rest of t=
he cooling
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devices. For example, if all cooling de=
vices have a
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0weight of 1, then they all contribute t=
he same. You can
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0use percentages if you want, but it's n=
ot mandatory. A
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0weight of 0 means that this cooling dev=
ice doesn't
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0contribute to the cooling of this zone =
unless all
> > cooling
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devices have a weight of 0. If all weig=
hts are 0, then
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0they all contribute the same.
> > +=C2=A0=C2=A0=C2=A0=C2=A0.trip_mask:
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This is a bit mask that giv=
es the binding relation
> > between
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0this thermal zone and cdev,=
 for a particular trip
> > point.
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0If nth bit is set, then the=
 cdev and thermal zone are
> > bound
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for trip point n.
> > +=C2=A0=C2=A0=C2=A0=C2=A0.binding_limits:
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This is an array of cooling state limi=
ts. Must
> > have
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0exactly 2 * thermal_zone.number_of_tri=
p_points.
> > It is an
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0array consisting of tuples <lower-stat=
e upper- =20
> > state> of =20
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0state limits. Each trip will be associ=
ated with
> > one state
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0limit tuple when binding. A NULL point=
er means
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<THERMAL_NO_LIMITS THERMAL_NO_LIMITS> =
on all
> > trips.
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0These limits are used when binding a c=
dev to a
> > trip point.
> > +=C2=A0=C2=A0=C2=A0=C2=A0.match:
> > +	=C2=A0=C2=A0=C2=A0=C2=A0This call back returns success(0) if the 'tz =
and cdev'
> > need to
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0be bound, as per platform data.
> > -1.4.2 struct thermal_zone_params
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0::
> > +
> > +	struct thermal_zone_params
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This structure defines the platform level=
 parameters for a
> > thermal zone.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This data, for each thermal zone should c=
ome from the platform
> > layer.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This is an optional feature where some pl=
atforms can choose not
> > to
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0provide this data.
> > -=C2=A0=C2=A0=C2=A0=C2=A0.governor_name: Name of the thermal governor u=
sed for this zone
> > -=C2=A0=C2=A0=C2=A0=C2=A0.no_hwmon: a boolean to indicate if the therma=
l to hwmon sysfs
> > interface
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0is required. when no_hwmon =3D=3D false, a hwmon sysfs
> > interface
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0will be created. when no_hwmon =3D=3D true, nothing wi=
ll
> > be done.
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0In case the thermal_zone_params is NULL, the hwmon
> > interface
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0will be created (for backward compatibility).
> > -=C2=A0=C2=A0=C2=A0=C2=A0.num_tbps: Number of thermal_bind_params entri=
es for this zone
> > -=C2=A0=C2=A0=C2=A0=C2=A0.tbp: thermal_bind_params entries
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0.governor_name:
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Name of the thermal governo=
r used for this zone
> > +=C2=A0=C2=A0=C2=A0=C2=A0.no_hwmon:
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0a boolean to indicate if th=
e thermal to hwmon sysfs
> > interface
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0is required. when no_hwmon =
=3D=3D false, a hwmon sysfs
> > interface
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0will be created. when no_hw=
mon =3D=3D true, nothing will
> > be done.
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0In case the thermal_zone_pa=
rams is NULL, the hwmon
> > interface
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0will be created (for backwa=
rd compatibility).
> > +=C2=A0=C2=A0=C2=A0=C2=A0.num_tbps:
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Number of thermal_bind_para=
ms entries for this zone
> > +=C2=A0=C2=A0=C2=A0=C2=A0.tbp:
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0thermal_bind_params entries
> > =C2=A0
> > =C2=A02. sysfs attributes structure
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > +=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0RO	read only value
> > =C2=A0WO	write only value
> > =C2=A0RW	read/write value
> > +=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > =C2=A0Thermal sysfs attributes will be represented under
> > /sys/class/thermal.
> > =C2=A0Hwmon sysfs I/F extension is also available under /sys/class/hwmon
> > =C2=A0if hwmon is compiled in or built as a module.
> > =C2=A0
> > -Thermal zone device sys I/F, created once it's registered:
> > -/sys/class/thermal/thermal_zone[0-*]:
> > +Thermal zone device sys I/F, created once it's registered::
> > +
> > +=C2=A0=C2=A0/sys/class/thermal/thermal_zone[0-*]:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---type:			Type of the thermal zone
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---temp:			Current temperature
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---mode:			Working mode of the thermal
> > zone
> > @@ -282,8 +396,9 @@ Thermal zone device sys I/F, created once it's
> > registered:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---slope:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0Slope constant applied as linear
> > extrapolation
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---offset:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Off=
set constant applied as linear
> > extrapolation
> > =C2=A0
> > -Thermal cooling device sys I/F, created once it's registered:
> > -/sys/class/thermal/cooling_device[0-*]:
> > +Thermal cooling device sys I/F, created once it's registered::
> > +
> > +=C2=A0=C2=A0/sys/class/thermal/cooling_device[0-*]:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---type:			Type of the cooling
> > device(processor/fan/...)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---max_state:		Maximum cooling state of =
the
> > cooling device
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---cur_state:		Current cooling state of =
the
> > cooling device
> > @@ -299,11 +414,13 @@ the relationship between a thermal zone and its
> > associated cooling device.
> > =C2=A0They are created/removed for each successful execution of
> > =C2=A0thermal_zone_bind_cooling_device/thermal_zone_unbind_cooling_devi=
ce.
> > =C2=A0
> > -/sys/class/thermal/thermal_zone[0-*]:
> > +::
> > +
> > +=C2=A0=C2=A0/sys/class/thermal/thermal_zone[0-*]:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---cdev[0-*]:		[0-*]th cooling device in=
 current
> > thermal zone
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---cdev[0-*]_trip_point:	Trip point that=
 cdev[0-*] is
> > associated with
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---cdev[0-*]_weight:=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0Influence of the cooling device in
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0this thermal zone
> > +				this thermal zone
> > =C2=A0
> > =C2=A0Besides the thermal zone device sysfs I/F and cooling device sysfs
> > I/F,
> > =C2=A0the generic thermal driver also creates a hwmon sysfs I/F for each
> > _type_
> > @@ -311,16 +428,17 @@ of thermal zone device. E.g. the generic
> > thermal driver registers one hwmon
> > =C2=A0class device and build the associated hwmon sysfs I/F for all the
> > registered
> > =C2=A0ACPI thermal zones.
> > =C2=A0
> > -/sys/class/hwmon/hwmon[0-*]:
> > +::
> > +
> > +=C2=A0=C2=A0/sys/class/hwmon/hwmon[0-*]:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---name:			The type of the thermal zone
> > devices
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---temp[1-*]_input:	The current temperat=
ure of thermal
> > zone [1-*]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---temp[1-*]_critical:	The critical trip=
 point of
> > thermal zone [1-*]
> > =C2=A0
> > =C2=A0Please read Documentation/hwmon/sysfs-interface.rst for additional
> > information.
> > =C2=A0
> > -***************************
> > -* Thermal zone attributes *
> > -***************************
> > +Thermal zone attributes
> > +-----------------------
> > =C2=A0
> > =C2=A0type
> > =C2=A0	Strings which represent the thermal zone type.
> > @@ -340,54 +458,67 @@ mode
> > =C2=A0	This file gives information about the algorithm that is
> > currently
> > =C2=A0	managing the thermal zone. It can be either default kernel
> > based
> > =C2=A0	algorithm or user space application.
> > -	enabled		=3D enable Kernel Thermal management.
> > -	disabled	=3D Preventing kernel thermal zone driver
> > actions upon
> > +
> > +	enabled
> > +			=C2=A0=C2=A0enable Kernel Thermal management.
> > +	disabled
> > +			=C2=A0=C2=A0Preventing kernel thermal zone driver
> > actions upon
> > =C2=A0			=C2=A0=C2=A0trip points so that user application can
> > take full
> > =C2=A0			=C2=A0=C2=A0charge of the thermal management.
> > +
> > =C2=A0	RW, Optional
> > =C2=A0
> > =C2=A0policy
> > =C2=A0	One of the various thermal governors used for a particular
> > zone.
> > +
> > =C2=A0	RW, Required
> > =C2=A0
> > =C2=A0available_policies
> > =C2=A0	Available thermal governors which can be used for a
> > particular zone.
> > +
> > =C2=A0	RO, Required
> > =C2=A0
> > -trip_point_[0-*]_temp
> > +`trip_point_[0-*]_temp`
> > =C2=A0	The temperature above which trip point will be fired.
> > +
> > =C2=A0	Unit: millidegree Celsius
> > +
> > =C2=A0	RO, Optional
> > =C2=A0
> > -trip_point_[0-*]_type
> > +`trip_point_[0-*]_type`
> > =C2=A0	Strings which indicate the type of the trip point.
> > -	E.g. it can be one of critical, hot, passive, active[0-*]
> > for ACPI
> > +
> > +	E.g. it can be one of critical, hot, passive, `active[0-*]`
> > for ACPI
> > =C2=A0	thermal zone.
> > +
> > =C2=A0	RO, Optional
> > =C2=A0
> > -trip_point_[0-*]_hyst
> > +`trip_point_[0-*]_hyst`
> > =C2=A0	The hysteresis value for a trip point, represented as an
> > integer
> > =C2=A0	Unit: Celsius
> > =C2=A0	RW, Optional
> > =C2=A0
> > -cdev[0-*]
> > +`cdev[0-*]`
> > =C2=A0	Sysfs link to the thermal cooling device node where the sys
> > I/F
> > =C2=A0	for cooling device throttling control represents.
> > +
> > =C2=A0	RO, Optional
> > =C2=A0
> > -cdev[0-*]_trip_point
> > -	The trip point in this thermal zone which cdev[0-*] is
> > associated
> > +`cdev[0-*]_trip_point`
> > +	The trip point in this thermal zone which `cdev[0-*]` is
> > associated
> > =C2=A0	with; -1 means the cooling device is not associated with any
> > trip
> > =C2=A0	point.
> > +
> > =C2=A0	RO, Optional
> > =C2=A0
> > -cdev[0-*]_weight
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0The influence of cdev[=
0-*] in this thermal zone. This value
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0is relative to the res=
t of cooling devices in the thermal
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0zone. For example, if =
a cooling device has a weight double
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0than that of other, it=
's twice as effective in cooling the
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0thermal zone.
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0RW, Optional
> > +`cdev[0-*]_weight`
> > +	The influence of `cdev[0-*]` in this thermal zone. This
> > value
> > +	is relative to the rest of cooling devices in the thermal
> > +	zone. For example, if a cooling device has a weight double
> > +	than that of other, it's twice as effective in cooling the
> > +	thermal zone.
> > +
> > +	RW, Optional
> > =C2=A0
> > =C2=A0passive
> > =C2=A0	Attribute is only present for zones in which the passive
> > cooling
> > @@ -395,8 +526,11 @@ passive
> > =C2=A0	and can be set to a temperature (in millidegrees) to enable
> > a
> > =C2=A0	passive trip point for the zone. Activation is done by
> > polling with
> > =C2=A0	an interval of 1 second.
> > +
> > =C2=A0	Unit: millidegrees Celsius
> > +
> > =C2=A0	Valid values: 0 (disabled) or greater than 1000
> > +
> > =C2=A0	RW, Optional
> > =C2=A0
> > =C2=A0emul_temp
> > @@ -407,17 +541,21 @@ emul_temp
> > =C2=A0	threshold and its associated cooling action. This is write
> > only node
> > =C2=A0	and writing 0 on this node should disable emulation.
> > =C2=A0	Unit: millidegree Celsius
> > +
> > =C2=A0	WO, Optional
> > =C2=A0
> > -	=C2=A0=C2=A0WARNING: Be careful while enabling this option on
> > production systems,
> > -	=C2=A0=C2=A0because userland can easily disable the thermal policy by
> > simply
> > -	=C2=A0=C2=A0flooding this sysfs node with low temperature values.
> > +	=C2=A0=C2=A0WARNING:
> > +	=C2=A0=C2=A0=C2=A0=C2=A0Be careful while enabling this option on prod=
uction
> > systems,
> > +	=C2=A0=C2=A0=C2=A0=C2=A0because userland can easily disable the therm=
al policy
> > by simply
> > +	=C2=A0=C2=A0=C2=A0=C2=A0flooding this sysfs node with low temperature=
 values.
> > =C2=A0
> > =C2=A0sustainable_power
> > =C2=A0	An estimate of the sustained power that can be dissipated by
> > =C2=A0	the thermal zone. Used by the power allocator governor. For
> > -	more information see
> > Documentation/thermal/power_allocator.txt
> > +	more information see
> > Documentation/thermal/power_allocator.rst
> > +
> > =C2=A0	Unit: milliwatts
> > +
> > =C2=A0	RW, Optional
> > =C2=A0
> > =C2=A0k_po
> > @@ -425,7 +563,8 @@ k_po
> > =C2=A0	controller during temperature overshoot. Temperature
> > overshoot
> > =C2=A0	is when the current temperature is above the "desired
> > =C2=A0	temperature" trip point. For more information see
> > -	Documentation/thermal/power_allocator.txt
> > +	Documentation/thermal/power_allocator.rst
> > +
> > =C2=A0	RW, Optional
> > =C2=A0
> > =C2=A0k_pu
> > @@ -433,20 +572,23 @@ k_pu
> > =C2=A0	controller during temperature undershoot. Temperature
> > undershoot
> > =C2=A0	is when the current temperature is below the "desired
> > =C2=A0	temperature" trip point. For more information see
> > -	Documentation/thermal/power_allocator.txt
> > +	Documentation/thermal/power_allocator.rst
> > +
> > =C2=A0	RW, Optional
> > =C2=A0
> > =C2=A0k_i
> > =C2=A0	The integral term of the power allocator governor's PID
> > =C2=A0	controller. This term allows the PID controller to
> > compensate
> > =C2=A0	for long term drift. For more information see
> > -	Documentation/thermal/power_allocator.txt
> > +	Documentation/thermal/power_allocator.rst
> > +
> > =C2=A0	RW, Optional
> > =C2=A0
> > =C2=A0k_d
> > =C2=A0	The derivative term of the power allocator governor's PID
> > =C2=A0	controller. For more information see
> > -	Documentation/thermal/power_allocator.txt
> > +	Documentation/thermal/power_allocator.rst
> > +
> > =C2=A0	RW, Optional
> > =C2=A0
> > =C2=A0integral_cutoff
> > @@ -456,8 +598,10 @@ integral_cutoff
> > =C2=A0	example, if integral_cutoff is 0, then the integral term
> > only
> > =C2=A0	accumulates error when temperature is above the desired
> > =C2=A0	temperature trip point. For more information see
> > -	Documentation/thermal/power_allocator.txt
> > +	Documentation/thermal/power_allocator.rst
> > +
> > =C2=A0	Unit: millidegree Celsius
> > +
> > =C2=A0	RW, Optional
> > =C2=A0
> > =C2=A0slope
> > @@ -465,6 +609,7 @@ slope
> > =C2=A0	to determine a hotspot temperature based off the sensor's
> > =C2=A0	raw readings. It is up to the device driver to determine
> > =C2=A0	the usage of these values.
> > +
> > =C2=A0	RW, Optional
> > =C2=A0
> > =C2=A0offset
> > @@ -472,28 +617,33 @@ offset
> > =C2=A0	to determine a hotspot temperature based off the sensor's
> > =C2=A0	raw readings. It is up to the device driver to determine
> > =C2=A0	the usage of these values.
> > +
> > =C2=A0	RW, Optional
> > =C2=A0
> > -*****************************
> > -* Cooling device attributes *
> > -*****************************
> > +Cooling device attributes
> > +-------------------------
> > =C2=A0
> > =C2=A0type
> > =C2=A0	String which represents the type of device, e.g:
> > +
> > =C2=A0	- for generic ACPI: should be "Fan", "Processor" or "LCD"
> > =C2=A0	- for memory controller device on intel_menlow platform:
> > =C2=A0	=C2=A0=C2=A0should be "Memory controller".
> > +
> > =C2=A0	RO, Required
> > =C2=A0
> > =C2=A0max_state
> > =C2=A0	The maximum permissible cooling state of this cooling
> > device.
> > +
> > =C2=A0	RO, Required
> > =C2=A0
> > =C2=A0cur_state
> > =C2=A0	The current cooling state of this cooling device.
> > =C2=A0	The value can any integer numbers between 0 and max_state:
> > +
> > =C2=A0	- cur_state =3D=3D 0 means no cooling
> > =C2=A0	- cur_state =3D=3D max_state means the maximum cooling.
> > +
> > =C2=A0	RW, Required
> > =C2=A0
> > =C2=A0stats/reset
> > @@ -508,9 +658,11 @@ stats/time_in_state_ms:
> > =C2=A0	units here is 10mS (similar to other time exported in
> > /proc).
> > =C2=A0	RO, Required
> > =C2=A0
> > +
> > =C2=A0stats/total_trans:
> > =C2=A0	A single positive value showing the total number of times
> > the state of a
> > =C2=A0	cooling device is changed.
> > +
> > =C2=A0	RO, Required
> > =C2=A0
> > =C2=A0stats/trans_table:
> > @@ -522,6 +674,7 @@ stats/trans_table:
> > =C2=A0	RO, Required
> > =C2=A0
> > =C2=A03. A simple implementation
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > =C2=A0
> > =C2=A0ACPI thermal zone may support multiple trip points like critical,
> > hot,
> > =C2=A0passive, active. If an ACPI thermal zone supports critical, passi=
ve,
> > @@ -532,11 +685,10 @@ thermal_cooling_device. Both are considered to
> > have the same
> > =C2=A0effectiveness in cooling the thermal zone.
> > =C2=A0
> > =C2=A0If the processor is listed in _PSL method, and the fan is listed =
in
> > _AL0
> > -method, the sys I/F structure will be built like this:
> > +method, the sys I/F structure will be built like this::
> > =C2=A0
> > -/sys/class/thermal:
> > -
> > -|thermal_zone1:
> > + /sys/class/thermal:
> > +=C2=A0=C2=A0|thermal_zone1:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---type:			acpitz
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---temp:			37000
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---mode:			enabled
> > @@ -557,24 +709,24 @@ method, the sys I/F structure will be built
> > like this:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---cdev1_trip_point:	2	/* cdev1 can be u=
sed for
> > active[0]*/
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---cdev1_weight:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01024
> > =C2=A0
> > -|cooling_device0:
> > +=C2=A0=C2=A0|cooling_device0:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---type:			Processor
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---max_state:		8
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---cur_state:		0
> > =C2=A0
> > -|cooling_device3:
> > +=C2=A0=C2=A0|cooling_device3:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---type:			Fan
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---max_state:		2
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---cur_state:		0
> > =C2=A0
> > -/sys/class/hwmon:
> > -
> > -|hwmon0:
> > + /sys/class/hwmon:
> > +=C2=A0=C2=A0|hwmon0:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---name:			acpitz
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---temp1_input:		37000
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|---temp1_crit:		100000
> > =C2=A0
> > =C2=A04. Event Notification
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > =C2=A0The framework includes a simple notification mechanism, in the fo=
rm
> > of a
> > =C2=A0netlink event. Netlink socket initialization is done during the
> > _init_
> > @@ -587,21 +739,28 @@ event will be one of:{THERMAL_AUX0,
> > THERMAL_AUX1, THERMAL_CRITICAL,
> > =C2=A0THERMAL_DEV_FAULT}. Notification can be sent when the current
> > temperature
> > =C2=A0crosses any of the configured thresholds.
> > =C2=A0
> > -5. Export Symbol APIs:
> > +5. Export Symbol APIs
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +5.1. get_tz_trend
> > +-----------------
> > =C2=A0
> > -5.1: get_tz_trend:
> > =C2=A0This function returns the trend of a thermal zone, i.e the rate of
> > change
> > =C2=A0of temperature of the thermal zone. Ideally, the thermal sensor
> > drivers
> > =C2=A0are supposed to implement the callback. If they don't, the thermal
> > =C2=A0framework calculated the trend by comparing the previous and the
> > current
> > =C2=A0temperature values.
> > =C2=A0
> > -5.2:get_thermal_instance:
> > +5.2. get_thermal_instance
> > +-------------------------
> > +
> > =C2=A0This function returns the thermal_instance corresponding to a giv=
en
> > =C2=A0{thermal_zone, cooling_device, trip_point} combination. Returns N=
ULL
> > =C2=A0if such an instance does not exist.
> > =C2=A0
> > -5.3:thermal_notify_framework:
> > +5.3. thermal_notify_framework
> > +-----------------------------
> > +
> > =C2=A0This function handles the trip events from sensor drivers. It sta=
rts
> > =C2=A0throttling the cooling devices according to the policy configured.
> > =C2=A0For CRITICAL and HOT trip points, this notifies the respective
> > drivers,
> > @@ -609,12 +768,15 @@ and does actual throttling for other trip
> > points i.e ACTIVE and PASSIVE.
> > =C2=A0The throttling policy is based on the configured platform data; if
> > no
> > =C2=A0platform data is provided, this uses the step_wise throttling
> > policy.
> > =C2=A0
> > -5.4:thermal_cdev_update:
> > +5.4. thermal_cdev_update
> > +------------------------
> > +
> > =C2=A0This function serves as an arbitrator to set the state of a cooli=
ng
> > =C2=A0device. It sets the cooling device to the deepest cooling state if
> > =C2=A0possible.
> > =C2=A0
> > -6. thermal_emergency_poweroff:
> > +6. thermal_emergency_poweroff
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > =C2=A0On an event of critical trip temperature crossing. Thermal framew=
ork
> > =C2=A0allows the system to shutdown gracefully by calling
> > orderly_poweroff().
> > diff --git a/Documentation/thermal/x86_pkg_temperature_thermal
> > b/Documentation/thermal/x86_pkg_temperature_thermal.rst
> > similarity index 80%
> > rename from Documentation/thermal/x86_pkg_temperature_thermal
> > rename to Documentation/thermal/x86_pkg_temperature_thermal.rst
> > index 17a3a4c0a0ca..f134dbd3f5a9 100644
> > --- a/Documentation/thermal/x86_pkg_temperature_thermal
> > +++ b/Documentation/thermal/x86_pkg_temperature_thermal.rst
> > @@ -1,19 +1,23 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0Kernel driver: x86_pkg_temp_thermal
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0
> > =C2=A0Supported chips:
> > +
> > =C2=A0* x86: with package level thermal management
> > +
> > =C2=A0(Verify using: CPUID.06H:EAX[bit 6] =3D1)
> > =C2=A0
> > =C2=A0Authors: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > =C2=A0
> > =C2=A0Reference
> > ----
> > +---------
> > +
> > =C2=A0Intel=C2=AE 64 and IA-32 Architectures Software Developer=E2=80=
=99s Manual (Jan,
> > 2013):
> > =C2=A0Chapter 14.6: PACKAGE LEVEL THERMAL MANAGEMENT
> > =C2=A0
> > =C2=A0Description
> > ----------
> > +-----------
> > =C2=A0
> > =C2=A0This driver register CPU digital temperature package level sensor=
 as
> > a thermal
> > =C2=A0zone with maximum two user mode configurable trip points. Number =
of
> > trip points
> > @@ -25,23 +29,27 @@ take any action to control temperature.
> > =C2=A0Threshold management
> > =C2=A0--------------------
> > =C2=A0Each package will register as a thermal zone under
> > /sys/class/thermal.
> > -Example:
> > -/sys/class/thermal/thermal_zone1
> > +
> > +Example::
> > +
> > +	/sys/class/thermal/thermal_zone1
> > =C2=A0
> > =C2=A0This contains two trip points:
> > +
> > =C2=A0- trip_point_0_temp
> > =C2=A0- trip_point_1_temp
> > =C2=A0
> > =C2=A0User can set any temperature between 0 to TJ-Max temperature.
> > Temperature units
> > -are in milli-degree Celsius. Refer to "Documentation/thermal/sysfs-
> > api.txt" for
> > +are in milli-degree Celsius. Refer to "Documentation/thermal/sysfs-
> > api.rst" for
> > =C2=A0thermal sys-fs details.
> > =C2=A0
> > =C2=A0Any value other than 0 in these trip points, can trigger thermal
> > notifications.
> > =C2=A0Setting 0, stops sending thermal notifications.
> > =C2=A0
> > -Thermal notifications: To get kobject-uevent notifications, set the
> > thermal zone
> > -policy to "user_space". For example: echo -n "user_space" > policy
> > -
> > -
> > +Thermal notifications:
> > +To get kobject-uevent notifications, set the thermal zone
> > +policy to "user_space".
> > =C2=A0
> > +For example::
> > =C2=A0
> > +	echo -n "user_space" > policy
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d9e214f68e52..b2254bc8e495 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15687,7 +15687,7 @@ M:	Viresh Kumar <viresh.kumar@linaro.o =20
> > rg> =20
> > =C2=A0M:	Javi Merino <javi.merino@kernel.org>
> > =C2=A0L:	linux-pm@vger.kernel.org
> > =C2=A0S:	Supported
> > -F:	Documentation/thermal/cpu-cooling-api.txt
> > +F:	Documentation/thermal/cpu-cooling-api.rst
> > =C2=A0F:	drivers/thermal/cpu_cooling.c
> > =C2=A0F:	include/linux/cpu_cooling.h
> > =C2=A0
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index 15a4ca5d7099..681047f8cc05 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -251,7 +251,7 @@ struct thermal_bind_params {
> > =C2=A0	=C2=A0* platform characterization. This value is relative to the
> > =C2=A0	=C2=A0* rest of the weights so a cooling device whose weight is
> > =C2=A0	=C2=A0* double that of another cooling device is twice as
> > -	=C2=A0* effective. See Documentation/thermal/sysfs-api.txt for
> > more
> > +	=C2=A0* effective. See Documentation/thermal/sysfs-api.rst for
> > more
> > =C2=A0	=C2=A0* information.
> > =C2=A0	=C2=A0*/
> > =C2=A0	int weight;
> > @@ -259,7 +259,7 @@ struct thermal_bind_params {
> > =C2=A0	/*
> > =C2=A0	=C2=A0* This is a bit mask that gives the binding relation
> > between this
> > =C2=A0	=C2=A0* thermal zone and cdev, for a particular trip point.
> > -	=C2=A0* See Documentation/thermal/sysfs-api.txt for more
> > information.
> > +	=C2=A0* See Documentation/thermal/sysfs-api.rst for more
> > information.
> > =C2=A0	=C2=A0*/
> > =C2=A0	int trip_mask;
> > =C2=A0 =20



Thanks,
Mauro
