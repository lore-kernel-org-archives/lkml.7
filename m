Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B1BFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A772168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405362AbfJPNbj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 09:31:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388342AbfJPNbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:31:38 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9GDRs6R064135
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 09:31:35 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vp1bqxdjg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 09:31:10 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sth@linux.ibm.com>;
        Wed, 16 Oct 2019 14:29:48 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Oct 2019 14:29:46 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9GDTguJ11862140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 13:29:42 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A24311C052;
        Wed, 16 Oct 2019 13:29:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8DF811C050;
        Wed, 16 Oct 2019 13:29:41 +0000 (GMT)
Received: from [9.152.214.37] (unknown [9.152.214.37])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Oct 2019 13:29:41 +0000 (GMT)
To:     Qian Cai <cai@lca.pw>, Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1570044801.5576.262.camel@lca.pw>
From:   Stefan Haberland <sth@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=sth@linux.ibm.com; keydata=
 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
 cH4TNHyhiR0KAbxE8qKx3Jc=
Subject: Re: memory leaks in dasd_eckd_check_characteristics() error paths
Date:   Wed, 16 Oct 2019 15:29:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1570044801.5576.262.camel@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19101613-0012-0000-0000-000003589894
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101613-0013-0000-0000-00002193B23F
Message-Id: <6f5584d5-755c-e416-52da-3cb99c69adaf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=65 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for reporting this.

On 02.10.19 21:33, Qian Cai wrote:
> For some reasons, dasd_eckd_check_characteristics() received -ENOMEM and then
> dasd_generic_set_online() emits this message,
>
> dasd: 0.0.0122 Setting the DASD online with discipline ECKD failed with rc=-12
>
> After that, there are several memory leaks below. There are "config_data" and
> then stored as,
>
> /* store per path conf_data */
> device->path[pos].conf_data = conf_data;
>
> When it processes the error path in  dasd_generic_set_online(), it calls
> dasd_delete_device() which nuke the whole "struct dasd_device" without freeing
> the device->path[].conf_data first. 

Usually dasd_delete_device() calls dasd_generic_free_discipline() which
takes care of
the device->path[].conf_data in dasd_eckd_uncheck_device().
From a first look this looks sane.

So I need to spend a closer look if this does not happen correctly here.

> Is it safe to free those in
> dasd_free_device() without worrying about the double-free? Or, is it better to
> free those in dasd_eckd_check_characteristics()'s goto error handling, i.e.,
> out_err*?
>
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -153,6 +153,9 @@ struct dasd_device *dasd_alloc_device(void)
>   */
>  void dasd_free_device(struct dasd_device *device)
>  {
> +       for (int i = 0; i < 8; i++)
> +               kfree(device->path[i].conf_data);
> +
>         kfree(device->private);
>         free_pages((unsigned long) device->ese_mem, 1);
>         free_page((unsigned long) device->erp_mem);
>
>
> unreferenced object 0x0fcee900 (size 256):
>   comm "dasdconf.sh", pid 446, jiffies 4294940081 (age 170.340s)
>   hex dump (first 32 bytes):
>     dc 01 01 00 f0 f0 f2 f1 f0 f7 f9 f0 f0 c9 c2 d4  ................
>     f7 f5 f0 f0 f0 f0 f0 f0 f0 c6 d9 c2 f7 f1 62 33  ..............b3
>   backtrace:
>     [<00000000a83b1992>] kmem_cache_alloc_trace+0x200/0x388
>     [<00000000048ef3e2>] dasd_eckd_read_conf+0x408/0x1400 [dasd_eckd_mod]
>     [<00000000ce31f195>] dasd_eckd_check_characteristics+0x3cc/0x938
> [dasd_eckd_mod]
>     [<00000000f6f1759b>] dasd_generic_set_online+0x150/0x4c0
>     [<00000000efca1efa>] ccw_device_set_online+0x324/0x808
>     [<00000000f9779774>] online_store_recog_and_online+0xe8/0x220
>     [<00000000349a5446>] online_store+0x2ce/0x420
>     [<000000005bd145f8>] kernfs_fop_write+0x1bc/0x270
>     [<0000000005664197>] vfs_write+0xce/0x220
>     [<0000000044a8bccb>] ksys_write+0xea/0x190
>     [<0000000037335938>] system_call+0x296/0x2b4


