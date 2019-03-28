Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B58C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9552183E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="n5L/VcJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfC1QZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:25:59 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:8273 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1QZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1553790354;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=aRUGz+nFBnOtZ00ha2qxt7NybBlw40MfowOm/cBxW0Q=;
        b=n5L/VcJlhES7jLhdxfKCcww1tipwWQNoy0xnk8hRPlecZQ8G2ZsfFEFXhPCwYd/VDh
        mTBcoihx2x+STFTiVi9+i7LVfiVdl2eAkH+M+lMhOZGriH99V9hidyiHvOtyJMx/dPFH
        27hS0zxpTE4sl47GI0YWE+mWAxu97PtqSrdmEuLcCsW8tAP+uwZPj9ImMFfsmGPf9VH8
        wbYlNVEhwPaBMkLGS/ZXyNvjd0GMSJXtH+u2AbeytVrdD2ueJreLfx492OA9FN/kza2z
        wN1zyZTzI8eppPfnzhx8/v7MzrybufHnP3gOI8leIOFIW9ZQwkduXfSDJcG6c4kY9gPy
        t/AQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlWdXA0IgQ=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id K07648v2SGPiMHx
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 28 Mar 2019 17:25:44 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/2] iio: gyro: bmg160: add device tree compatibility table
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190324180503.6dc1e36e@archlinux>
Date:   Thu, 28 Mar 2019 17:25:43 +0100
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Content-Transfer-Encoding: 7bit
Message-Id: <E093DD9D-C9DF-4725-8BAC-0451766E0A0C@goldelico.com>
References: <cover.1552922054.git.hns@goldelico.com> <090c92487ada60e81fca341ef24e5de33a11ec4b.1552922054.git.hns@goldelico.com> <20190324180503.6dc1e36e@archlinux>
To:     Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,
> Am 24.03.2019 um 19:05 schrieb Jonathan Cameron <jic23@kernel.org>:
> 
> On Mon, 18 Mar 2019 16:14:14 +0100
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
> 
>> Add of_match_table.
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> I'm not against doing this, but do note that there is still a back up
> path in which the i2c_device_id table is used to match but without
> the vendor part of the string.
> 
> I theory the plan is to eventually remove that, but it's not the
> case that this driver could not be probed from devicetree previously.
> 
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.

Thanks,
Nikolaus

> 
> Thanks,
> 
> Jonathan
> 
>> ---
>> drivers/iio/gyro/bmg160_i2c.c | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>> 
>> diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
>> index 90126a5a7663..934a092134f0 100644
>> --- a/drivers/iio/gyro/bmg160_i2c.c
>> +++ b/drivers/iio/gyro/bmg160_i2c.c
>> @@ -54,10 +54,19 @@ static const struct i2c_device_id bmg160_i2c_id[] = {
>> 
>> MODULE_DEVICE_TABLE(i2c, bmg160_i2c_id);
>> 
>> +static const struct of_device_id bmg160_of_match[] = {
>> +	{ .compatible = "bosch,bmg160" },
>> +	{ .compatible = "bosch,bmi055_gyro" },
>> +	{ }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, bmg160_of_match);
>> +
>> static struct i2c_driver bmg160_i2c_driver = {
>> 	.driver = {
>> 		.name	= "bmg160_i2c",
>> 		.acpi_match_table = ACPI_PTR(bmg160_acpi_match),
>> +		.of_match_table = bmg160_of_match,
>> 		.pm	= &bmg160_pm_ops,
>> 	},
>> 	.probe		= bmg160_i2c_probe,
> 

