Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EEEC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442DB20873
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="atSosEhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfDKINo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:13:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46458 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfDKINn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:13:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3B845Jc131842;
        Thu, 11 Apr 2019 08:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=CxALe2+dMErVQcQun0unMbr1R8fjHmrE6/VoYNtRrJQ=;
 b=atSosEhgum2VewBWb8dX4kK0AAVcOdcnuzktvxfJYnszgcTcxmfKtOWdbLa8w8GQvi7I
 h+DBJMqbdqOgcc42ZAAW20+1b9h7Crx4i4nFCTVwFoZBXXK5J2Ic7bLaiAaK+muNizfX
 FeCQhWfQh+J/g9QH1t64jwwaXBq6brtajOfbp4PmySpWbvteK95bZNDLoIdpH7L5AGxY
 GxiM2YCUsrjBwoUVGBo61YBK5Myz6MWc3t7hVSn02RSOVrXufKI1U2b0bhN4atAP6evq
 oDYG6vNM276jqSaK0ZL2LhwuBp6rv0AMK6QYcmdGegAm2ooIhdziiI+XSSOfrQ2gEzep 1A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2rpmrqf9ty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 08:13:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3B8D0tq156829;
        Thu, 11 Apr 2019 08:13:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2rph7tm81e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 08:13:38 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3B8Dbmx019557;
        Thu, 11 Apr 2019 08:13:37 GMT
Received: from kadam (/41.202.241.15)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Apr 2019 01:13:36 -0700
Date:   Thu, 11 Apr 2019 11:13:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Madhumthia Prabakaran <madhumithabiw@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8723bs: Remove typedef in struct sdio_data
Message-ID: <20190411081328.GF31633@kadam>
References: <20190409161617.29871-1-madhumithabiw@gmail.com>
 <20190410064954.GE6095@kadam>
 <20190410194908.GA13242@madhuleo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410194908.GA13242@madhuleo>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904110059
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904110058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 02:49:09PM -0500, Madhumthia Prabakaran wrote:
> On Wed, Apr 10, 2019 at 09:49:54AM +0300, Dan Carpenter wrote:
> > On Tue, Apr 09, 2019 at 11:16:17AM -0500, Madhumitha Prabakaran wrote:
> > > diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
> > > index bafb2c30e7fb..b0623c936940 100644
> > > --- a/drivers/staging/rtl8723bs/include/drv_types.h
> > > +++ b/drivers/staging/rtl8723bs/include/drv_types.h
> > > @@ -220,7 +220,7 @@ struct registry_priv
> > >  #define BSSID_SZ(field)   sizeof(((struct wlan_bssid_ex *) 0)->field)
> > >  
> > >  #include <drv_types_sdio.h>
> > > -#define INTF_DATA SDIO_DATA
> > > +#define INTF_DATA struct sdio_data
> > >  
> > 
> > Just get rid of INTF_DATA data as well.  It's only used once a bit lower
> > in the file.  (Get rid of the ifdef around it).
> 
> But, reference of INTF_DATA is also included in file 
> ./drivers/staging/rtl8723bs/include/drv_types.h:487:
> return &dvobj->intf_data.func->dev;
> 

Actually, I maybe misunderstood your email.  I'm not sure what you mean
about "&dvobj->intf_data.func->dev;".  I just meant to replace
INTF_DATA with "struct sdio_data".

regards,
dan carpenter

