Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0E4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7634206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NB6QoECL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfDWM7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:59:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48826 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfDWM7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:59:32 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3NCxF3F020838;
        Tue, 23 Apr 2019 07:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556024356;
        bh=m1GaqatvcHWGft1cimldRpq3+Wj+GxtgYLjUb+o/um0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NB6QoECLRNos4h+LyPekREh6avE1ehKMm/Iau7Gx5y+d0OuXGjKRz7mBB6JkzjmQy
         k8tLTvpSWNTtjO+glgiiHorq0phRTveHqNmkTizTLeRQmg08eUNLtDk+tnHz2A5OzF
         HmlyZDDBSgT7N40U81M1oE0syn6ehVLSQ4NuPT/0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3NCxFKO032853
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Apr 2019 07:59:15 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 23
 Apr 2019 07:59:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 23 Apr 2019 07:59:13 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3NCxBkt070170;
        Tue, 23 Apr 2019 07:59:12 -0500
Subject: Re: [PATCH v3 0/4] drm/panel: Support for OSD101T2045-53TS and
 OSD101T2587-53TS
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <tomi.valkeinen@ti.com>, <sam@ravnborg.org>
References: <20190226075523.28997-1-peter.ujfalusi@ti.com>
 <20190423115506.GE23448@ulmo>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <c25a9364-f69f-17b4-34d6-ec29e68118d3@ti.com>
Date:   Tue, 23 Apr 2019 16:00:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423115506.GE23448@ulmo>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On 23/04/2019 14.55, Thierry Reding wrote:
> On Tue, Feb 26, 2019 at 09:55:19AM +0200, Peter Ujfalusi wrote:
>> Hi,
>>
>> Changes since v2:
>> - Added Reviewed-by from Rob to the binding patches
>> - Added help text to Kconfig (osd101t2587-53ts)
>> - Print the error values in dev_err/warn
>> - Added Reviewed-by from Sam to the osd101t2587-53ts patch
>>
>> Changes since v1 (only panel-osd-osd101t2587-53ts changed):
>> - Removed unused members from struct osd101t2587_panel
>> - Use backlight_enable/backlight_disable
>> - Use devm_of_find_backlight()
>> - osd101t2587_of_match table standardized 
>> - osd101t2587_panel_unprepare() added to shutdown and remove callbacks to turn
>>   power off
>> - Fix probe in case mipi_dsi_attach() would fail
>>
>> Add support for OSD101T2045-53TS and OSD101T2587-53TS from One Stop Displays.
>>
>> The two panel is similar with one big difference: OSD101T2587-53TS requires the
>> MIPI_DSI_TURN_ON_PERIPHERAL message, thus can not be handled by panel-simple.
>>
>> Regards,
>> Peter
>> ---
>> Peter Ujfalusi (4):
>>   dt-bindings: display: Add bindings for OSD101T2045-53TS
>>   drm/panel: simple: Add support for OSD101T2045-53TS
>>   dt-bindings: display: Add bindings for OSD101T2587-53TS panel
>>   drm/panel: Add OSD101T2587-53TS driver
>>
>>  .../display/panel/osd,osd101t2045-53ts.txt    |  11 +
>>  .../display/panel/osd,osd101t2587-53ts.txt    |  14 +
>>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>>  drivers/gpu/drm/panel/Makefile                |   1 +
>>  .../drm/panel/panel-osd-osd101t2587-53ts.c    | 254 ++++++++++++++++++
>>  drivers/gpu/drm/panel/panel-simple.c          |  34 +++
>>  6 files changed, 323 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/display/panel/osd,osd101t2045-53ts.txt
>>  create mode 100644 Documentation/devicetree/bindings/display/panel/osd,osd101t2587-53ts.txt
>>  create mode 100644 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
> 
> Applied all four patches. Note that I had to change the osd vendor
> string to osddisplays, which is the one that is documented in
> vendor-prefixes.txt.

I recall checking the vendor-prefixes.txt and not finding OSD in there.
Odd, as it is indeed there.

> I'm assuming that this is the same vendor, based on the model names. If
> this is a different vendor, do let me know.

Yes it is the same one.

Thank you and sorry for missing it,
- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
