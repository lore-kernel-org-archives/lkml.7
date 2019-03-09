Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE145C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A848820815
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552154307;
	bh=eEC90eXOHeIZUvwN742xDcq9MTfWcgjo+qVppyN9QBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ci4afyY4h/qtdYK/7XwMH70MbF5C8MW394ME5AHet0peKcU288mm4E3sa5LjDbREV
	 0apsXMW6Hgwg/y/Ndd6omUnMX7bKcHwEL1aB8D2+p6/l5QcYYxkAsM4xEBF0qlHy+M
	 DPDVO5r37crt/EDTdSLc/5KJl/JYsJk/xdFIYnEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfCIR60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 12:58:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfCIR60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 12:58:26 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBE6A20645;
        Sat,  9 Mar 2019 17:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552154304;
        bh=eEC90eXOHeIZUvwN742xDcq9MTfWcgjo+qVppyN9QBo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v0/1JRgUP8JRezXfyWGa362NuurmN7XnOqILByxEGwr60qaL7hWy2w4oqG/vZ282Q
         G97fEWeZPRXSd7TiaU1j0JA/y68smCmsWdiIFRgQkz5Clt/lQnmuskJIlhgHd7JvJF
         n8btTNaKD29T4uz6QhEFSi+v/EcqbhnLdYWTNOLo=
Date:   Sat, 9 Mar 2019 17:58:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 3/4] staging: iio: ad5933: add ABI documentation
Message-ID: <20190309175819.603aac7f@archlinux>
In-Reply-To: <20190303193007.2zyvil4gmr7pv2pp@smtp.gmail.com>
References: <20190301025314.p53nlcfey3qarms4@smtp.gmail.com>
        <20190303121341.7a689124@archlinux>
        <20190303193007.2zyvil4gmr7pv2pp@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Mar 2019 16:30:07 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 03/03, Jonathan Cameron wrote:
> > On Thu, 28 Feb 2019 23:53:14 -0300
> > Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> >  =20
> > > Add an ABI documentation for the ad5933 driver.
> > >=20
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com> =20
> > Hi Marcelo,
> >=20
> > The ABI that you have defined which is actually new is mostly fine,
> > however it seems that some of the existing ABI is not used correctly
> > and that will need to be fixed.
> >=20
> > Jonathan =20
>=20
> Hi Jonathan,
>=20
> Thanks for the comments.
>=20
> >  =20
> > > ---
> > >  .../ABI/testing/sysfs-bus-iio-ad5933          | 91 +++++++++++++++++=
++
> > >  1 file changed, 91 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ad5933
> > >=20
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-ad5933 b/Documen=
tation/ABI/testing/sysfs-bus-iio-ad5933
> > > new file mode 100644
> > > index 000000000000..81e3d3f6f724
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-ad5933
> > > @@ -0,0 +1,91 @@
> > > +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_scale
> > > +Date:		February 2019
> > > +KernelVersion:	Kernel 4.19
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		The output peak-to-peak voltage range. Writting 0 sets range
> > > +		to 2.0V p-p typical, 1 sets range to 200mV p-p typical, 2 sets
> > > +		range to 400mV p-p typical, 3 sets range to 1.0V p-p typical.
> > > +		The p-p value of the ac output exitation voltage scales with=20
> > > +		supply voltage according to the following formula:
> > > +		Output Excitation Voltage (V p-p) =3D normalized_3v3 =C3=97 [VDD/3=
.3]
> > > +		where normalized_3v3 is one of the four voltage range above and
> > > +		VDD is the supply voltage. =20
> >=20
> > Definitely not. The device must comply with standard ABI and this is not
> > using it correctly (see below or the docs).
> >  =20
> > > +
> > > +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_scale_available
> > > +Date:		February 2019
> > > +KernelVersion:	Kernel 4.19
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:=09
> > > +		Prints available peak-to-peak voltage range to buffer. =20
> >=20
> > I really hope it doesn't.  Scale is a mulitplier not a range.  It shoul=
d be
> > printing out the value by which the _raw reading should be multiplied to
> > get the voltage in the base units for voltage (millivolts) =20
>=20
> As the driver is right now I believe that calling this device attribute w=
ill
> print "1980, 970, 383, 198" which are the mean values of four distributio=
ns
> (called range1 to range4) of possible actual millivolt values used as the=
 AC
> output excitation.
Interesting.
> Certainly they don't mean "the value by which the _raw
> reading should be multiplied to get the voltage in the base units for vol=
tage"
> so, as you said, this ABI is probably being misused here. Hence, I guess
> I ought to change this attribute's call to something different than=20
> out_voltage0_scale_available (as well as the out_voltage0_scale above). M=
aybe
> out_voltage0_excit_available or out_voltage0_mean_excit_available, any ot=
her
> suggestion?
It's a perfectly good output alternating voltage, we have altvoltage
for that where the value corresponds to peak to peak voltage.
However, I've just noticed we don't actually seem to specify 'how'
that is measured. Hmm. My assumption would be that existing
devices are measuring peak voltage.

Given voltage is measured in millivolts anyway,
out_altvoltage_raw of 0,1,2,3 with scale also provided as 198 should
work nicely I think?

>=20
> >  =20
> > > +
> > > +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_start
> > > +Date:		February 2019
> > > +KernelVersion:	Kernel 4.19
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		The start frequency. Set this to define de frequency point at
> > > +		which the device should start the next frequency sweep. Default
> > > +		start frequency point set to 10000Hz. =20
> >=20
> > No need to specify the default. It's trivial to read and any user of th=
is
> > chip should set it to the value they want. =20
>=20
> OK, then I will remove these on the next patch.
>=20
> >  =20
> > > +
> > > +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_increment
> > > +Date:		February 2019
> > > +KernelVersion:	Kernel 4.19
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		The frequency sweep increment. Set this to define at which rate
> > > +		frequency sweep points are incremented.  =20
> > Rate is a temporal term.  Perhaps "step by which the frequency is incre=
mented"? =20
>=20
> Maybe
>=20
> "define the amount by which the frequency is incremented after each scan =
point."
>=20
> would it be ok?

That's good.

>=20
> >  =20
> > > After the measurement at
> > > +		a frequency point is completed, the next measurement will be=20
> > > +		made with a frequency 'frequency increment'Hz higher than the
> > > +		previous point until the defined number of increments has been
> > > +		made. Default frequency increment set to 200Hz. =20
> >=20
> > No need to specify the default. People can just read the file to find t=
hat out.
> >  =20
> > > +	=09
> > > +
> > > +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_points
> > > +Date:		February 2019
> > > +KernelVersion:	Kernel 4.19
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		The number of increments. This defines the number of frequency
> > > +		points in the frequency sweep. Device stores a 9-bit integer
> > > +		number in binary format for this so the maximum number of
> > > +		increments that can be programmed is 511. =20
> > I would relax this ABI description so that it doesn't describe the bit =
depth
> > and ideally doesn't describe the range either.  If we want to provide t=
he
> > range, then provide an available attribute to pair with this.
> >=20
> > The reason is that we should be looking to define interfaces in a way t=
hat
> > allows them to be potentially generalised to similar devices in future.
> >=20
> > I suspect a lot of this is generic to impedance measuring ICs.
> >  =20
>=20
> Then I think we would keep just the very beginning of it "The number of .=
..=20
> frequency sweep."
Agreed.

>=20
> > > +
> > > +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_settling_cycles
> > > +Date:		February 2019
> > > +KernelVersion:	Kernel 4.19
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Number of settling time cycles. This attribute is a 11 bit field
> > > +		divided in two parts. The 9 least significant bit define the
> > > +		number of output excitation cycles that are passed through the
> > > +		unknown impedance, after the receipt of a start frequency sweep,
> > > +		increment frequency, or repeat frequency command, before the ADC
> > > +		is triggered to perform a conversion of the response signal. The
> > > +		2 most significant bits define a multiplier for the number of
> > > +		cycles obtained from de least significant bits. Let D10 and D9 =20
> >=20
> > de -> the  =20
>=20
> oops, thanks for pointing it out.
>=20
> >  =20
> > > +		be these two bits, the resulting multiplier is defined as
> > > +		follows.
> > > +		D10 D9 =3D 0 0 =3D> No. of cycles x 1 (default)
> > > +		D10 D9 =3D 0 1 =3D> No. of cycles x 2
> > > +		D10 D9 =3D 1 0 =3D> Reserved
> > > +		D10 D9 =3D 1 1 =3D> No. of cycles x 4
> > > +
> > > +		See the datasheet for detailed information. =20
> >=20
> > Hmm. This is a bizare interface - but such is hardware.
> >=20
> > However, just because it is bizare in the hardware doesn't mean the
> > userspace interface should be.  Just hide all this complexity and
> > map whatever number of cycles is input to the nearest possible value.
> > =20
>=20
> Trying to be generic I would say:
>=20
> 	Number of settling time cycles. This sets the delay between a start
> 	frequency sweep/increment frequency /repeat frequency to be proportional
> 	to the excitation signal frequency times the number of settling time
> 	cycles.

Good.

> =20
> > > +
> > > +What:/sys/bus/iio/devices/iio:deviceX/in_voltage0_scale
> > > +Date:		February 2019
> > > +KernelVersion:	Kernel 4.19
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		The PGA gain amplifier for the response signal. Set this to 0
> > > +		to gain the output of the current-to-voltage amplifier by a
> > > +		factor of 5. Set to 1 (default) to amplify the response signal
> > > +		into the ADC by a multiplication factor of x1.
> > > +
> > > +What:/sys/bus/iio/devices/iio:deviceX/in_voltage0_scale_available =20
> >=20
> > There is no need to document standard ABI.  If this isn't documented in=
 the
> > main Documentation/ABI/testing/sysfs-bus-iio please add it there. =20
>=20
> I guess this would be /sys/bus/iio/devices/iio:deviceX/in_voltage_scale.
>=20
> >  =20
> > > +Date:		February 2019
> > > +KernelVersion:	Kernel 4.19
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Prints available PGA gain amplifier to buffer. =20
> > Pga is one element that should effect this, but it's not the only
> > one.  The resolution of the device also matters for example.
> >=20
> > =20
> =20
> Weren't this one described in /sys/.../iio:deviceX/in_voltageX_scale_avai=
lable?

Yes, it should be so don't have it here.


Jonathan
>=20

