Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FAEC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4EB20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="hjMK4PXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfCGMyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:54:06 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:23202 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfCGMyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1551963239;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=WJWbt+4uXrF5kNzctZOC4lubGT3KGd/C6/LGNxUyyBQ=;
        b=hjMK4PXPSw0kcPTM6jm1WraR/wd/TC6s3ohBbOBAjt3u7fI93McMugqR+ApJHPgQLO
        dUH2Qr4DDXkELXTyIUxdC+pXK/J/FUwsntPeT9aKaHg+60MZ5JMfALvhXjHEVKbla0UX
        5IeS8iuCZ2jNHr0uRsu9/eWOG19ZyOro3stUVx7qshqF6sU+QsWEfie09aP6p6wvVOA+
        w7UyNCqSmOzIcLbd4jCJ6E7lNW8PpcjAghx4SOsuIZhHtsQPHg31GKQWSbwemRVWlvXD
        nvU1rUQ+CBTScmVVYzwokYVKnqBj/VgGa4r99KwZp6wam39vNVBye+jRcDDmaimewXto
        f6Zw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmMlw4jk6g=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.13 DYNA|AUTH)
        with ESMTPSA id h0b8c2v27CrouL5
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 7 Mar 2019 13:53:50 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 02/10] iio: document bindings for mounting matrices
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190303151911.1e134bd4@archlinux>
Date:   Thu, 7 Mar 2019 13:53:50 +0100
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        letux-kernel@openphoenux.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sebastian Reichel <sre@kernel.org>,
        Samu Onkalo <samu.onkalo@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B4B3C161-1F74-483A-9761-EC751618B7FD@goldelico.com>
References: <cover.1550768574.git.hns@goldelico.com> <32025b2a8ccc97cc01f8115ee962529eb5990f00.1550768574.git.hns@goldelico.com> <20190303151911.1e134bd4@archlinux>
To:     Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

> Am 03.03.2019 um 16:19 schrieb Jonathan Cameron <jic23@kernel.org>:
>=20
> On Thu, 21 Feb 2019 18:02:47 +0100
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>=20
>> From: Linus Walleij <linus.walleij@linaro.org>
>>=20
>> The mounting matrix for sensors was introduced in
>> commit dfc57732ad38 ("iio:core: mounting matrix support")
>>=20
>> However the device tree bindings are very terse and since this is
>> a widely applicable property, we need a proper binding for it
>> that the other bindings can reference. This will also be useful
>> for other operating systems and sensor engineering at large.
>>=20
>> I think all 3D sensors should support it, the current situation
>> is probably that the mounting information is confined in magic
>> userspace components rather than using the mounting matrix, which
>> is not good for portability and reuse.
>>=20
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Gregor Boirie <gregor.boirie@parrot.com>
>> Cc: Sebastian Reichel <sre@kernel.org>
>> Cc: Samu Onkalo <samu.onkalo@intel.com>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Hi Nikolaus
>=20
> A few minor notes inline.

>=20
>> ---
>> .../devicetree/bindings/iio/mount-matrix.txt  | 204 =
++++++++++++++++++
>> 1 file changed, 204 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/iio/mount-matrix.txt
>>=20
>> diff --git a/Documentation/devicetree/bindings/iio/mount-matrix.txt =
b/Documentation/devicetree/bindings/iio/mount-matrix.txt
>> new file mode 100644
>> index 000000000000..1b64c8b1f689
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/mount-matrix.txt
>> @@ -0,0 +1,204 @@
>> +For discussion. Unclear are:
>> +* is the definition of +/- values practical or counterintuitive?
>> +* are the definitions unambiguous and easy to follow?
>> +* are the examples correct?
>> +* should we have HOWTO engineer a correct matrix for a new device =
(without comparing to a different one)?
>> +
>> +=3D=3D=3D=3D
>> +
>> +
>> +Mounting matrix
>> +
>> +The mounting matrix is a device tree property used to orient any IIO =
device
>=20
> Minor, but DT bindings are in theory not Linux specific and IIO is, so
> should be "any device"
>=20
>> +that produce three-dimensional data in relation to the world where =
it is
>> +deployed.
>> +
>> +The purpose of the mounting matrix is to translate the sensor frame =
of
>> +reference into the device frame of reference using a translation =
matrix as
>> +defined in linear algebra.
>> +
>> +The typical usecase is that where a component has an internal =
representation
>> +of the (x,y,z) triplets, such as different registers to read these =
coordinates,
>> +and thus implying that the component should be mounted in a certain =
orientation
>> +relative to some specific device frame of reference.
>> +
>> +For example a device with some kind of screen, where the user is =
supposed to
>> +interact with the environment using an accelerometer, gyroscope or =
magnetometer
>> +mounted on the same chassis as this screen, will likely take the =
screen as
>> +reference to (x,y,z) orientation, with (x,y) corresponding to these =
axes on the
>> +screen and (z) being depth, the axis perpendicular to the screen.
>> +
>> +For a screen you probably want (x) coordinates to go from negative =
on the left
>> +to positive on the right, (y) from negative on the bottom to =
positive on top
>> +and (z) depth to be negative under the screen and positive in front =
of it,
>> +toward the face of the user.
>> +
>> +A sensor can be mounted in any angle along the axes relative to the =
frame of
>> +reference. This means that the sensor may be flipped upside-down, =
left-right,
>> +or tilted at any angle relative to the frame of reference.
>> +
>> +Another frame of reference is how the device with its sensor relates =
to the
>> +external world, the environment where the device is deployed. =
Usually the data
>> +from the sensor is used to figure out how the device is oriented =
with respect
>> +to this world. When using the mounting matrix, the sensor and device =
orientation
>> +becomes identical and we can focus on the data as it relates to the =
surrounding
>> +world.
>> +
>> +Device-to-world examples for some three-dimensional sensor types:
>> +
>> +- Accelerometers have their world frame of reference toward the =
center of
>> +  gravity, usually to the core of the planet. A reading of the =
(x,y,z) values
>> +  from the sensor will give a projection of the gravity vector =
through the
>> +  device relative to the center of the planet, i.e. relative to its =
surface at
>> +  this point. Up and down in the world relative to the device frame =
of
>> +  reference can thus be determined. and users would likely expect a =
value of
>> +  9.81 m/s^2 upwards along the (z) axis, i.e. out of the screen when =
the device
>> +  is held with its screen flat on the planets surface and 0 on the =
other axes,
>> +  as the gravity vector is projected 1:1 onto the sensors (z)-axis.
>=20
> Nitpick: Screen is face down or face up?  Someone might think a screen =
is
> flat when looking up at them from the floor or the other way up.
> I 'think' it's face down in the following...
>=20
>=20
>> +
>> +  If you tilt the device, the g vector virtually coming out of the =
display
>> +  is projected onto the (x,y) plane of the display panel.
>> +
>> +  Example:
>> +
>=20
> space after > for z. Or making it consistent anyway.
> Hmm.=20
>=20
>> +         ^ z: +g                   ^ z: >0
>> +         !                        /!
>> +         ! x=3Dy=3D0                 / ! x: > 0
>> +     +--------+             +--------+
>> +     !        !             !        !
>> +     +--------+             +--------+
>> +         !                    /
>> +         !                   /
>> +         v                  v
>> +      center of         center of
>> +       gravity           gravity
>> +
>> +
>> +  If the device is tilted to the left, you get a positive x value. =
If you point
>> +  its top towards surface, you get a negative y axis.
>> +
>> +     (---------)
>> +     !         !           y: -g
>> +     !         !             ^
>> +     !         !             !
>> +     !         !
>> +     !         !  x: +g <- z: +g  -> x: -g
>> +     ! 1  2  3 !
>> +     ! 4  5  6 !             !
>> +     ! 7  8  9 !             v
>> +     ! *  0  # !           y: +g
>> +     (---------)
>> +
>> +
>> +- Magnetometers (compasses) have their world frame of reference =
relative to the
>> +  geomagnetic field. The system orientation vis-a-vis the world is =
defined with
>> +  respect to the local earth geomagnetic reference frame where (y) =
is in the
>> +  ground plane and positive towards magnetic North, (x) is in the =
ground plane,
>> +  perpendicular to the North axis and positive towards the East and =
(z) is
>> +  perpendicular to the ground plane and positive upwards.
>> +
>> +
>> +     ^^^ North: y > 0
>> +
>> +     (---------)
>> +     !         !
>> +     !         !
>> +     !         !
>> +     !         !  >
>> +     !         !  > North: x > 0
>> +     ! 1  2  3 !  >
>> +     ! 4  5  6 !
>> +     ! 7  8  9 !
>> +     ! *  0  # !
>> +     (---------)
>> +
>> +  Since the geomagnetic field is not uniform this definition fails =
if we come
>> +  closer to the poles.
>> +
>> +  Sensors and driver can not and should not take care of this =
because there
>> +  are complex calculations and empirical data to be taken care of. =
We leave
>> +  this up to user space.
>> +
>> +  The definition we take:
>> +
>> +  If the device is placed at the equator and the top is pointing =
north, the
>> +  display is readable by a person standing upright on the earth =
surface, this
>> +  defines a positive y value.
> Nice definition. <wonders how consistent it is at the equator - meh =
close enough :)>
>> +
>> +
>> +- Gyroscopes detects the movement relative the device itself. The =
angular
>> +  velocity is defined as orthogonal to the plane of rotation, so if =
you put the
>> +  device on a flat surface and spin it around the z axis (such as =
rotating a
>> +  device with a screen lying flat on a table), you should get a =
negative value
>> +  along the (z) axis if rotated clockwise, and a positive value if =
rotated
>> +  counter-clockwise according to the right-hand rule.
>> +
>> +
>> +     (---------)     y > 0
>> +     !         !     v---\
>> +     !         !
>> +     !         !
>> +     !         !      <--\
>> +     !         !         ! z > 0
>> +     ! 1  2  3 !       --/
>> +     ! 4  5  6 !
>> +     ! 7  8  9 !
>> +     ! *  0  # !
>> +     (---------)
>> +
>> +
>> +So unless the sensor is ideally mounted, we need a means to indicate =
the
>> +relative orientation of any given sensor of this type with respect =
to the
>> +frame of reference.
>> +
>> +To achieve this, use the device tree property "mount-matrix" for the =
sensor.
>> +
>> +This supplies a 3x3 rotation matrix in the strict linear algebraic =
sense,
>> +to orient the senor axes relative to a desired point of reference. =
This means
>> +the resulting values from the sensor, after scaling to proper units, =
should be
>> +multiplied by this matrix to give the proper vectors values in =
three-dimensional
>> +space, relative to the device or world point of reference.
>> +
>> +For more information, consult:
>> +https://en.wikipedia.org/wiki/Rotation_matrix
>> +
>> +The mounting matrix has the layout:
>> +
>> + (mxx, myx, mzx)
>> + (mxy, myy, mzy)
>> + (mxz, myz, mzz)
>> +
>> +Values are intended to be multiplied as:
>> +
>> +  x' =3D mxx * x + myx * y + mzx * z
>> +  y' =3D mxy * x + myy * y + mzy * z
>> +  z' =3D mxz * x + myz * y + mzz * z
>> +
>> +It is represented as an array of strings containing the real values =
for
>> +producing the transformation matrix. The real values use a decimal =
point and
>> +a minus (-) to indicate a negative value.
>=20
> I'd drop the decimal point and negative as both fairly obvious and =
this
> sentence can currently be read as a decimal point is necessary for a =
negative.
>=20
>> +
>> +Examples:
>> +
>> +Identity matrix (nothing happens to the coordinates, which means the =
device was
>> +mechanically mounted in an ideal way and we need no transformation):
>> +
>> +mount-matrix =3D "1", "0", "0",
>> +               "0", "1", "0",
>> +               "0", "0", "1";
>> +
>> +The sensor is mounted 30 degrees (Pi/6 radians) tilted along the X =
axis, so we
>> +compensate by performing a -30 degrees rotation around the X axis:
>> +
>> +mount-matrix =3D "1", "0", "0",
>> +               "0", "0.866", "0.5",
>> +               "0", "-0.5", "0.866";
>> +
>> +The sensor is flipped 180 degrees (Pi radians) around the Z axis, =
i.e. mounted
>> +upside-down:
>> +
>> +mount-matrix =3D "0.998", "0.054", "0",
>> +               "-0.054", "0.998", "0",
>> +               "0", "0", "1";
>> +
>> +???: this does not match "180 degrees" - factors indicate ca. 3 =
degrees compensation
> Yes. Good to say this.
>=20
> Very nice indeed, just these little tidy ups and I'm very happy with =
the
> result!
>=20
> Jonathan


Thanks for pushing the other patches forwards.

Yes, I know this needs more discussion. So I'll go through your comments =
in a few days and post an update just for this.

BR and thanks,
Nikolaus


