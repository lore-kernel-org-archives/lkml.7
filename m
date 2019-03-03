Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30CFC10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCC520866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551626362;
	bh=7JHEdgFSzZ+bHV7NrXNQRU2he/QhwmUwGlCxPSyVIY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oIqsFaDq+fE+V5bWt5QUikehnSjpZ4KywFRwkuK02bynXNCyUle+WnplM9ivnakVr
	 QrO8QMXu90Dd8LyXvSmEHhOig5qiEPATAilZRQ92K4R/FZzrDf8VbdoXLpe0Z4ExGg
	 T8SFdtDQgqtl4v7etk20Jf6r20zHtCqjGaUXQ5BU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfCCPTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 10:19:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfCCPTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 10:19:20 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E42DE20836;
        Sun,  3 Mar 2019 15:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551626359;
        bh=7JHEdgFSzZ+bHV7NrXNQRU2he/QhwmUwGlCxPSyVIY0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i+jj1ncZ6FMD8LCyvt1oD5gONxXitTdCXzb1HxR4FhB8JvpiP/rCWJ/GhMoJ979Al
         yyrmf9DsfEtujPJtTA8EM8MaOWZgxRvlliMJAVrH7CWBDQWpC2dgxLvOsd/R2l7EWB
         U+PKfm0KV2Huev5yuoz2g7qnxwgr0/NE6s4nqJ7g=
Date:   Sun, 3 Mar 2019 15:19:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
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
Subject: Re: [PATCH v2 02/10] iio: document bindings for mounting matrices
Message-ID: <20190303151911.1e134bd4@archlinux>
In-Reply-To: <32025b2a8ccc97cc01f8115ee962529eb5990f00.1550768574.git.hns@goldelico.com>
References: <cover.1550768574.git.hns@goldelico.com>
        <32025b2a8ccc97cc01f8115ee962529eb5990f00.1550768574.git.hns@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 18:02:47 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The mounting matrix for sensors was introduced in
> commit dfc57732ad38 ("iio:core: mounting matrix support")
> 
> However the device tree bindings are very terse and since this is
> a widely applicable property, we need a proper binding for it
> that the other bindings can reference. This will also be useful
> for other operating systems and sensor engineering at large.
> 
> I think all 3D sensors should support it, the current situation
> is probably that the mounting information is confined in magic
> userspace components rather than using the mounting matrix, which
> is not good for portability and reuse.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Gregor Boirie <gregor.boirie@parrot.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Samu Onkalo <samu.onkalo@intel.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Hi Nikolaus

A few minor notes inline.

> ---
>  .../devicetree/bindings/iio/mount-matrix.txt  | 204 ++++++++++++++++++
>  1 file changed, 204 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/mount-matrix.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/mount-matrix.txt b/Documentation/devicetree/bindings/iio/mount-matrix.txt
> new file mode 100644
> index 000000000000..1b64c8b1f689
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/mount-matrix.txt
> @@ -0,0 +1,204 @@
> +For discussion. Unclear are:
> +* is the definition of +/- values practical or counterintuitive?
> +* are the definitions unambiguous and easy to follow?
> +* are the examples correct?
> +* should we have HOWTO engineer a correct matrix for a new device (without comparing to a different one)?
> +
> +====
> +
> +
> +Mounting matrix
> +
> +The mounting matrix is a device tree property used to orient any IIO device

Minor, but DT bindings are in theory not Linux specific and IIO is, so
should be "any device"

> +that produce three-dimensional data in relation to the world where it is
> +deployed.
> +
> +The purpose of the mounting matrix is to translate the sensor frame of
> +reference into the device frame of reference using a translation matrix as
> +defined in linear algebra.
> +
> +The typical usecase is that where a component has an internal representation
> +of the (x,y,z) triplets, such as different registers to read these coordinates,
> +and thus implying that the component should be mounted in a certain orientation
> +relative to some specific device frame of reference.
> +
> +For example a device with some kind of screen, where the user is supposed to
> +interact with the environment using an accelerometer, gyroscope or magnetometer
> +mounted on the same chassis as this screen, will likely take the screen as
> +reference to (x,y,z) orientation, with (x,y) corresponding to these axes on the
> +screen and (z) being depth, the axis perpendicular to the screen.
> +
> +For a screen you probably want (x) coordinates to go from negative on the left
> +to positive on the right, (y) from negative on the bottom to positive on top
> +and (z) depth to be negative under the screen and positive in front of it,
> +toward the face of the user.
> +
> +A sensor can be mounted in any angle along the axes relative to the frame of
> +reference. This means that the sensor may be flipped upside-down, left-right,
> +or tilted at any angle relative to the frame of reference.
> +
> +Another frame of reference is how the device with its sensor relates to the
> +external world, the environment where the device is deployed. Usually the data
> +from the sensor is used to figure out how the device is oriented with respect
> +to this world. When using the mounting matrix, the sensor and device orientation
> +becomes identical and we can focus on the data as it relates to the surrounding
> +world.
> +
> +Device-to-world examples for some three-dimensional sensor types:
> +
> +- Accelerometers have their world frame of reference toward the center of
> +  gravity, usually to the core of the planet. A reading of the (x,y,z) values
> +  from the sensor will give a projection of the gravity vector through the
> +  device relative to the center of the planet, i.e. relative to its surface at
> +  this point. Up and down in the world relative to the device frame of
> +  reference can thus be determined. and users would likely expect a value of
> +  9.81 m/s^2 upwards along the (z) axis, i.e. out of the screen when the device
> +  is held with its screen flat on the planets surface and 0 on the other axes,
> +  as the gravity vector is projected 1:1 onto the sensors (z)-axis.

Nitpick: Screen is face down or face up?  Someone might think a screen is
flat when looking up at them from the floor or the other way up.
I 'think' it's face down in the following...


> +
> +  If you tilt the device, the g vector virtually coming out of the display
> +  is projected onto the (x,y) plane of the display panel.
> +
> +  Example:
> +

space after > for z. Or making it consistent anyway.
Hmm. 

> +         ^ z: +g                   ^ z: >0
> +         !                        /!
> +         ! x=y=0                 / ! x: > 0
> +     +--------+             +--------+
> +     !        !             !        !
> +     +--------+             +--------+
> +         !                    /
> +         !                   /
> +         v                  v
> +      center of         center of
> +       gravity           gravity
> +
> +
> +  If the device is tilted to the left, you get a positive x value. If you point
> +  its top towards surface, you get a negative y axis.
> +
> +     (---------)
> +     !         !           y: -g
> +     !         !             ^
> +     !         !             !
> +     !         !
> +     !         !  x: +g <- z: +g  -> x: -g
> +     ! 1  2  3 !
> +     ! 4  5  6 !             !
> +     ! 7  8  9 !             v
> +     ! *  0  # !           y: +g
> +     (---------)
> +
> +
> +- Magnetometers (compasses) have their world frame of reference relative to the
> +  geomagnetic field. The system orientation vis-a-vis the world is defined with
> +  respect to the local earth geomagnetic reference frame where (y) is in the
> +  ground plane and positive towards magnetic North, (x) is in the ground plane,
> +  perpendicular to the North axis and positive towards the East and (z) is
> +  perpendicular to the ground plane and positive upwards.
> +
> +
> +     ^^^ North: y > 0
> +
> +     (---------)
> +     !         !
> +     !         !
> +     !         !
> +     !         !  >
> +     !         !  > North: x > 0
> +     ! 1  2  3 !  >
> +     ! 4  5  6 !
> +     ! 7  8  9 !
> +     ! *  0  # !
> +     (---------)
> +
> +  Since the geomagnetic field is not uniform this definition fails if we come
> +  closer to the poles.
> +
> +  Sensors and driver can not and should not take care of this because there
> +  are complex calculations and empirical data to be taken care of. We leave
> +  this up to user space.
> +
> +  The definition we take:
> +
> +  If the device is placed at the equator and the top is pointing north, the
> +  display is readable by a person standing upright on the earth surface, this
> +  defines a positive y value.
Nice definition. <wonders how consistent it is at the equator - meh close enough :)>
> +
> +
> +- Gyroscopes detects the movement relative the device itself. The angular
> +  velocity is defined as orthogonal to the plane of rotation, so if you put the
> +  device on a flat surface and spin it around the z axis (such as rotating a
> +  device with a screen lying flat on a table), you should get a negative value
> +  along the (z) axis if rotated clockwise, and a positive value if rotated
> +  counter-clockwise according to the right-hand rule.
> +
> +
> +     (---------)     y > 0
> +     !         !     v---\
> +     !         !
> +     !         !
> +     !         !      <--\
> +     !         !         ! z > 0
> +     ! 1  2  3 !       --/
> +     ! 4  5  6 !
> +     ! 7  8  9 !
> +     ! *  0  # !
> +     (---------)
> +
> +
> +So unless the sensor is ideally mounted, we need a means to indicate the
> +relative orientation of any given sensor of this type with respect to the
> +frame of reference.
> +
> +To achieve this, use the device tree property "mount-matrix" for the sensor.
> +
> +This supplies a 3x3 rotation matrix in the strict linear algebraic sense,
> +to orient the senor axes relative to a desired point of reference. This means
> +the resulting values from the sensor, after scaling to proper units, should be
> +multiplied by this matrix to give the proper vectors values in three-dimensional
> +space, relative to the device or world point of reference.
> +
> +For more information, consult:
> +https://en.wikipedia.org/wiki/Rotation_matrix
> +
> +The mounting matrix has the layout:
> +
> + (mxx, myx, mzx)
> + (mxy, myy, mzy)
> + (mxz, myz, mzz)
> +
> +Values are intended to be multiplied as:
> +
> +  x' = mxx * x + myx * y + mzx * z
> +  y' = mxy * x + myy * y + mzy * z
> +  z' = mxz * x + myz * y + mzz * z
> +
> +It is represented as an array of strings containing the real values for
> +producing the transformation matrix. The real values use a decimal point and
> +a minus (-) to indicate a negative value.

I'd drop the decimal point and negative as both fairly obvious and this
sentence can currently be read as a decimal point is necessary for a negative.

> +
> +Examples:
> +
> +Identity matrix (nothing happens to the coordinates, which means the device was
> +mechanically mounted in an ideal way and we need no transformation):
> +
> +mount-matrix = "1", "0", "0",
> +               "0", "1", "0",
> +               "0", "0", "1";
> +
> +The sensor is mounted 30 degrees (Pi/6 radians) tilted along the X axis, so we
> +compensate by performing a -30 degrees rotation around the X axis:
> +
> +mount-matrix = "1", "0", "0",
> +               "0", "0.866", "0.5",
> +               "0", "-0.5", "0.866";
> +
> +The sensor is flipped 180 degrees (Pi radians) around the Z axis, i.e. mounted
> +upside-down:
> +
> +mount-matrix = "0.998", "0.054", "0",
> +               "-0.054", "0.998", "0",
> +               "0", "0", "1";
> +
> +???: this does not match "180 degrees" - factors indicate ca. 3 degrees compensation
Yes. Good to say this.

Very nice indeed, just these little tidy ups and I'm very happy with the
result!

Jonathan


