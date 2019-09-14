Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DA4C49ED6
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 04:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB1F206BB
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 04:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S2OEA5rW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfINEJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 00:09:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55056 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfINEJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 00:09:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8E44IDS187626;
        Sat, 14 Sep 2019 04:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=M2/PQ514w7qwCqbZjusq/fdmAFfmnPpnokTzMBkrkbw=;
 b=S2OEA5rWUyx+8aDgMSvtikNmncxEk/yTntfNonphjEQbLvfqyLkXZVqF8TpZM6sS0lOh
 xMVsHYwJpF4V7wicDvUNfROPBDilNN3mlY/MS1g6F0UsC2IFrD7t8SKXzB4KrPmWnXRy
 ZFTvt3XlK6c1Pp8JhKA7qjv+iwlOa0INF3MORWzZNQtg8OM8FlbMc4QtSmsduZ87J7fP
 rGADpIb2gs+2R+oyzrWVCzmN2qtQ3K0BtYuoyL1+8GyN/3a/tCwpXIKzobD/7SoNRCyB
 XQpFj7D7ccBBhlrWy7FqwtRVCBTMLFzkqFWQ08byWmuiZ30en5LX+wn8sZg0gug432ia yQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2v0r5p03gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Sep 2019 04:09:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8E480qU023918;
        Sat, 14 Sep 2019 04:09:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2v0p8sb7qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Sep 2019 04:09:08 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8E495h2024354;
        Sat, 14 Sep 2019 04:09:06 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Sep 2019 21:09:05 -0700
Date:   Sat, 14 Sep 2019 07:08:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Jani Nikula <jani.nikula@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: drivers/gpu/drm/i915/display/intel_display.c:3934 skl_plane_stride()
 error: testing array offset 'color_plane' after use.
Message-ID: <20190914040858.GT20699@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909140040
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909140039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a7f89616b7376495424f682b6086e0c391a89a1d
commit: df0566a641f959108c152be748a0a58794280e0e drm/i915: move modesetting core code under display/
date:   3 months ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/gpu/drm/i915/display/intel_display.c:3934 skl_plane_stride() error: testing array offset 'color_plane' after use.
drivers/gpu/drm/i915/display/intel_display.c:16328 intel_sanitize_encoder() error: we previously assumed 'crtc' could be null (see line 16318)

git remote add linus https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout df0566a641f959108c152be748a0a58794280e0e
vim +/color_plane +3934 drivers/gpu/drm/i915/display/intel_display.c

b3cf5c06ca5001 drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2018-09-25  3926  
df79cf44191029 drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2018-09-11  3927  u32 skl_plane_stride(const struct intel_plane_state *plane_state,
5d2a19507cb665 drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2018-09-07  3928  		     int color_plane)
d21967740f4b7d drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2016-01-28  3929  {
df79cf44191029 drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2018-09-11  3930  	const struct drm_framebuffer *fb = plane_state->base.fb;
df79cf44191029 drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2018-09-11  3931  	unsigned int rotation = plane_state->base.rotation;
5d2a19507cb665 drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2018-09-07  3932  	u32 stride = plane_state->color_plane[color_plane].stride;
                                                                                                                              ^^^^^^^^^^^
Out of bounds read?

1b500535c513ac drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2017-03-07  3933  
5d2a19507cb665 drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2018-09-07 @3934  	if (color_plane >= fb->format->num_planes)
                                                                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Tested too late.

1b500535c513ac drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2017-03-07  3935  		return 0;
1b500535c513ac drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2017-03-07  3936  
b3cf5c06ca5001 drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2018-09-25  3937  	return stride / skl_plane_stride_mult(fb, color_plane, rotation);
d21967740f4b7d drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2016-01-28  3938  }
d21967740f4b7d drivers/gpu/drm/i915/intel_display.c Ville Syrjälä 2016-01-28  3939  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
