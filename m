Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE2DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E5A21841
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WzV3YhX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfCULTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:19:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40932 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCULTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:19:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2LB4PG2011912;
        Thu, 21 Mar 2019 11:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=+CJEDJDV8tQlaLOEq1gYhqwy9hEc1BIFmium5TeXdTU=;
 b=WzV3YhX7GTERYIllfGWH0lMhUu7JlfzZ2vIPq9XtmOf2nZCzAElC7c0C4fiGw5wiqhaK
 mUYCycxVnvbM3PygFseVblhmnDSFTb9gydljjwLqUvSGWzEvs4SdD2Vc3ynF8+2BlG+L
 WwJ6xdGL72PBJsoSYKb+DwNHBX2SFtYEf1zsx9migKCRf5A7MlUJ6kMH89nNraGhL8ja
 yC0JLNrmM92JsnLjb5mQFJIqyCBXDCqHSDjXSqizGIIW5EI8HlR5xcA3OPufohxKKQWo
 2m6dhOs3rwoEYX7bc5l+7ybTg7/UvGgdGg92onAB3a3/X89Gz0amBXEUCerEB+LNQZpT BQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2r8rjuyvam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 11:19:28 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2LBJNFG003439
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 11:19:23 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2LBJLEd007773;
        Thu, 21 Mar 2019 11:19:21 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Mar 2019 04:19:21 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 1/3] mm/sparse: Clean up the obsolete code comment
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190321103521.GO8696@dhcp22.suse.cz>
Date:   Thu, 21 Mar 2019 05:19:19 -0600
Cc:     Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        rppt@linux.vnet.ibm.com, richard.weiyang@gmail.com,
        linux-mm@kvack.org
Content-Transfer-Encoding: 7bit
Message-Id: <EAFD8223-BEED-4985-8CD4-D3410A5898A6@oracle.com>
References: <20190320073540.12866-1-bhe@redhat.com>
 <20190320111959.GV19508@bombadil.infradead.org>
 <20190320122011.stuoqugpjdt3d7cd@d104.suse.de>
 <20190320122243.GX19508@bombadil.infradead.org>
 <20190320123658.GF13626@rapoport-lnx>
 <20190320125843.GY19508@bombadil.infradead.org>
 <20190321064029.GW18740@MiWiFi-R3L-srv>
 <20190321092138.GY18740@MiWiFi-R3L-srv>
 <3FFF0A5F-AD27-4F31-8ECF-3B72135CF560@oracle.com>
 <20190321103521.GO8696@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9201 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=764 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903210082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 21, 2019, at 4:35 AM, Michal Hocko <mhocko@kernel.org> wrote:
> 
> I am sorry to be snarky but hasn't this generated way much more email
> traffic than it really deserves? A simply and trivial clean up in the
> beginning that was it, right?

That's rather the point; that it did generate a fair amount of email
traffic indicates it's worthy of at least a passing mention in a
comment somewhere.
