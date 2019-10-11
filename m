Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B3CECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6D8214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="odX5tTsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfJKKCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 06:02:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51162 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfJKKCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:02:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9B9scC2162644;
        Fri, 11 Oct 2019 10:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=+GPs3yD7k8TANwLI8v1G3L+HkQq52VFBQSkyO/JfTyE=;
 b=odX5tTsJa0N71+IkxfdmUXvmEusAA53/PDqRxAan/RFa/hmwkroe1IkemC7cVLrTpbgq
 Ntc4hHrHkT494iiN4RvosRl592XT44LaXQq86Z/hU1mcciF1BwxQcL1L2AtTHowHwMTG
 Db4GWZiJijm8y2pk2QJkucjCu86u/H53uUkZqRghIK+dnwfXNerMZPFS7j4fKDSE1MbJ
 Murg+1L0S9gJBkgW5Ap9LT3gacnXJ6sr0PHqNmzyBE+lv80nPLwVtCmZsSbGzpI4bgca
 48oFMirO25Aon5imzxEqwMdoxyUmI7TPNHL5RyLXHnn4wozC5daoapKAKeUcIseIG5fF TA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vek4r0hy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 10:02:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9B9rWsx027913;
        Fri, 11 Oct 2019 10:02:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vhrxg5gm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 10:02:29 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9BA2LJL020372;
        Fri, 11 Oct 2019 10:02:21 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Oct 2019 03:02:20 -0700
Date:   Fri, 11 Oct 2019 13:02:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Matt Sickler <Matt.Sickler@daktronics.com>
Cc:     Chandra Annamaneni <chandra627@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "gneukum1@gmail.com" <gneukum1@gmail.com>,
        "fabian.krueger@fau.de" <fabian.krueger@fau.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "simon@nikanor.nu" <simon@nikanor.nu>
Subject: Re: [PATCH] KPC2000: kpc2000_spi.c: Fix style issues (line length)
Message-ID: <20191011100214.GO13286@kadam>
References: <1570676937-3975-1-git-send-email-chandra627@gmail.com>
 <SN6PR02MB40166D599A07440D26EBE7F1EE940@SN6PR02MB4016.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB40166D599A07440D26EBE7F1EE940@SN6PR02MB4016.namprd02.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9406 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910110094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9406 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910110094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 02:54:59PM +0000, Matt Sickler wrote:
> > static struct mtd_partition p2kr0_spi1_parts[] = {
> >-       { .name = "SLOT_4",     .size = 7798784,                .offset = 0,                },
> >-       { .name = "SLOT_5",     .size = 7798784,                .offset = MTDPART_OFS_NXTBLK},
> >-       { .name = "SLOT_6",     .size = 7798784,                .offset = MTDPART_OFS_NXTBLK},
> >-       { .name = "SLOT_7",     .size = 7798784,                .offset = MTDPART_OFS_NXTBLK},
> >-       { .name = "CS1_EXTRA",  .size = MTDPART_SIZ_FULL,       .offset = MTDPART_OFS_NXTBLK},
> >+       { .name = "SLOT_4",  .size = 7798784,  .offset = 0,},
> >+       { .name = "SLOT_5",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
> >+       { .name = "SLOT_6",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
> >+       { .name = "SLOT_7",  .size = 7798784,  .offset = MTDPART_OFS_NXTBLK},
> >+       { .name = "CS1_EXTRA",  .size = MTDPART_SIZ_FULL, .offset = MTDPART_OFS_NXTBLK},
> > };
> >
> > static struct flash_platform_data p2kr0_spi0_pdata = {
> 
> Is the line length limit a hard rule or can exceptions be made?  I
> really feel that these data tables are more easily read when they're
> formatted like tables...

Exceptions can be made.  It's probably not worth it though because
you have to be really aggressive about shooting down patches.  Ask
yourself if there aren't more important battles to fight when human
lifespans are so short?  I already rejected one change for you.  To me
the new table looks okay, though.

regards,
dan carpenter
